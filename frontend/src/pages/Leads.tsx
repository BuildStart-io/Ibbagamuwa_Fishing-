import { useCallback, useEffect, useMemo, useState } from "react";
import { useNavigate } from "react-router-dom";
import { supabase } from "@/integrations/supabase/client";
import DashboardLayout from "@/components/layout/DashboardLayout";
import { useAuth } from "@/hooks/useAuth";
import { useEffectivePlan } from "@/hooks/useEffectivePlan";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Switch } from "@/components/ui/switch";
import { Label } from "@/components/ui/label";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { useToast } from "@/hooks/use-toast";
import { MessageSquare, Sparkles, Lock, Users, Search, MapPin, Package, Clock, CreditCard } from "lucide-react";
import { cn } from "@/lib/utils";

// 7 PRD-mandated lifecycle stages (PRD Section 3.5)
export const LEAD_STATUSES = [
  { value: "new_inquiry", label: "New Inquiry" },
  { value: "exploring_packages", label: "Exploring Packages" },
  { value: "qualification_in_progress", label: "Qualifying" },
  { value: "qualified_lead", label: "Qualified Lead (Location)" },
  { value: "bank_transfer_pending", label: "Bank Transfer Pending" },
  { value: "cod_confirmed", label: "COD Confirmed" },
  { value: "filtered_out", label: "Filtered Out / Casual" },
];

export const normalizeLeadStatus = (raw: string | null | undefined): string => {
  if (!raw) return "new_inquiry";
  if (raw === "new") return "new_inquiry";
  if (raw === "reached") return "exploring_packages";
  if (raw === "follow_up") return "qualification_in_progress";
  if (raw === "converted") return "cod_confirmed";
  if (raw === "lost") return "filtered_out";
  return raw;
};

const UNASSIGNED = "__unassigned__";
const ALL = "__all__";

interface StaffOption {
  staff_user_id: string;
  staff_name: string | null;
  staff_email: string;
  whatsapp_number?: string | null;
}

interface LeadRow {
  id: string | null;
  phone_number: string;
  customer_name: string;
  assigned_to: string | null;
  status: string;
  location: string | null;
  district: string | null;
  package_interest: string | null;
  quantity: number;
  purchase_timeline: string | null;
  payment_preference: string | null;
  inbound_count: number;
  has_order: boolean;
  last_time: string | null;
}

export default function Leads() {
  const { user } = useAuth();
  const navigate = useNavigate();
  const { toast } = useToast();
  const { effectiveUserId, isStaff, isGrowth, loading: planLoading } = useEffectivePlan();

  const [rows, setRows] = useState<LeadRow[]>([]);
  const [staff, setStaff] = useState<StaffOption[]>([]);
  const [loading, setLoading] = useState(true);
  const [autoAssign, setAutoAssign] = useState(false);
  const [search, setSearch] = useState("");
  const [filterStaff, setFilterStaff] = useState<string>(ALL);
  const [filterStatus, setFilterStatus] = useState<string>(ALL);
  const [filterDistrict, setFilterDistrict] = useState<string>(ALL);
  const [qualifiedOnly, setQualifiedOnly] = useState(false);

  const isOwner = !isStaff;

  const load = useCallback(async () => {
    if (!effectiveUserId || !isGrowth) {
      setLoading(false);
      return;
    }
    setLoading(true);
    try {
      const [convRes, orderRes, leadRes, staffRes, settingRes] = await Promise.all([
        supabase
          .from("conversations")
          .select("phone_number, direction, metadata, created_at")
          .eq("user_id", effectiveUserId)
          .order("created_at", { ascending: false }),
        supabase
          .from("orders")
          .select("customer_phone, whatsapp_phone, customer_address, district")
          .eq("user_id", effectiveUserId),
        supabase
          .from("leads" as any)
          .select("id, phone_number, customer_name, assigned_to, status, location, district, package_interest, quantity, purchase_timeline, payment_preference")
          .eq("user_id", effectiveUserId),
        supabase
          .from("staff_accounts")
          .select("staff_user_id, staff_name, staff_email, whatsapp_number")
          .eq("owner_id", effectiveUserId)
          .eq("is_active", true),
        supabase
          .from("settings")
          .select("value")
          .eq("user_id", effectiveUserId)
          .eq("key", "leads_auto_assign")
          .maybeSingle(),
      ]);

      const staffList = (staffRes.data || []) as StaffOption[];
      setStaff(staffList);
      setAutoAssign(Boolean((settingRes.data?.value as any)?.enabled));

      const orderPhones = new Set<string>();
      const orderLocationMap = new Map<string, { address: string | null; district: string | null }>();
      (orderRes.data || []).forEach((o: any) => {
        if (o.customer_phone) {
          orderPhones.add(String(o.customer_phone));
          if (!orderLocationMap.has(String(o.customer_phone))) {
            orderLocationMap.set(String(o.customer_phone), { address: o.customer_address, district: o.district });
          }
        }
        if (o.whatsapp_phone) {
          orderPhones.add(String(o.whatsapp_phone));
          if (!orderLocationMap.has(String(o.whatsapp_phone))) {
            orderLocationMap.set(String(o.whatsapp_phone), { address: o.customer_address, district: o.district });
          }
        }
      });

      const stats = new Map<
        string,
        { inbound: number; name: string; last: string }
      >();
      (convRes.data || []).forEach((m: any) => {
        const entry = stats.get(m.phone_number) || {
          inbound: 0,
          name: "",
          last: m.created_at,
        };
        if (m.direction === "inbound") {
          entry.inbound += 1;
          if (!entry.name) entry.name = (m.metadata as any)?.senderName || "";
        }
        if (m.created_at > entry.last) entry.last = m.created_at;
        stats.set(m.phone_number, entry);
      });

      const leadMap = new Map<string, any>();
      ((leadRes.data as any[]) || []).forEach((l) => leadMap.set(l.phone_number, l));

      // Owners create missing lead records so staff can be assigned
      if (isOwner) {
        const missing = Array.from(stats.entries())
          .filter(([phone]) => !leadMap.has(phone))
          .map(([phone, s]) => {
            const orderLoc = orderLocationMap.get(phone);
            return {
              user_id: effectiveUserId,
              phone_number: phone,
              customer_name: s.name || null,
              status: "new_inquiry",
              location: orderLoc?.address || null,
              district: orderLoc?.district || null,
            };
          });
        if (missing.length > 0) {
          const { data: inserted } = await (supabase.from("leads" as any) as any)
            .upsert(missing, { onConflict: "user_id,phone_number" })
            .select("id, phone_number, customer_name, assigned_to, status, location, district, package_interest, quantity, purchase_timeline, payment_preference");
          ((inserted as any[]) || []).forEach((l) => leadMap.set(l.phone_number, l));
        }
      }

      const phones = isOwner
        ? Array.from(new Set([...stats.keys(), ...leadMap.keys()]))
        : Array.from(leadMap.keys());

      const built: LeadRow[] = phones.map((phone) => {
        const s = stats.get(phone);
        const l = leadMap.get(phone);
        const orderLoc = orderLocationMap.get(phone);
        return {
          id: l?.id ?? null,
          phone_number: phone,
          customer_name: l?.customer_name || s?.name || "Unknown",
          assigned_to: l?.assigned_to ?? null,
          status: normalizeLeadStatus(l?.status),
          location: l?.location || orderLoc?.address || null,
          district: l?.district || orderLoc?.district || null,
          package_interest: l?.package_interest || null,
          quantity: l?.quantity || 1,
          purchase_timeline: l?.purchase_timeline || null,
          payment_preference: l?.payment_preference || null,
          inbound_count: s?.inbound || 0,
          has_order: orderPhones.has(phone),
          last_time: s?.last || null,
        };
      });

      built.sort((a, b) => (b.last_time || "").localeCompare(a.last_time || ""));
      setRows(built);
    } catch (err: any) {
      toast({ title: "Error loading leads", description: err.message, variant: "destructive" });
    } finally {
      setLoading(false);
    }
  }, [effectiveUserId, isGrowth, isOwner, toast]);

  useEffect(() => {
    if (!planLoading) load();
  }, [planLoading, load]);

  // Auto-assign unassigned leads in round-robin order (owner side)
  useEffect(() => {
    if (!isOwner || !autoAssign || loading || staff.length === 0) return;
    const unassigned = rows.filter((r) => !r.assigned_to && r.id);
    if (unassigned.length === 0) return;

    const counts = new Map<string, number>();
    staff.forEach((s) => counts.set(s.staff_user_id, 0));
    rows.forEach((r) => {
      if (r.assigned_to && counts.has(r.assigned_to)) {
        counts.set(r.assigned_to, (counts.get(r.assigned_to) || 0) + 1);
      }
    });

    (async () => {
      const updates: { id: string; staffId: string }[] = [];
      for (const lead of unassigned) {
        let target = staff[0].staff_user_id;
        let min = Infinity;
        for (const s of staff) {
          const c = counts.get(s.staff_user_id) || 0;
          if (c < min) {
            min = c;
            target = s.staff_user_id;
          }
        }
        counts.set(target, (counts.get(target) || 0) + 1);
        updates.push({ id: lead.id as string, staffId: target });
      }
      await Promise.all(
        updates.map((u) =>
          (supabase.from("leads" as any) as any)
            .update({ assigned_to: u.staffId })
            .eq("id", u.id)
        )
      );
      updates.forEach((u) => {
        const lead = rows.find((r) => r.id === u.id);
        if (lead) notifyStaffAssignment(u.staffId, lead);
      });
      setRows((prev) =>
        prev.map((r) => {
          const u = updates.find((x) => x.id === r.id);
          return u ? { ...r, assigned_to: u.staffId } : r;
        })
      );
    })();
  }, [autoAssign, rows, staff, isOwner, loading]);

  const toggleAutoAssign = async (checked: boolean) => {
    if (!effectiveUserId) return;
    setAutoAssign(checked);
    const { error } = await supabase
      .from("settings")
      .upsert(
        { user_id: effectiveUserId, key: "leads_auto_assign", value: { enabled: checked } },
        { onConflict: "user_id,key" }
      );
    if (error) {
      toast({ title: "Error", description: error.message, variant: "destructive" });
      return;
    }
    toast({ title: checked ? "Auto-assign enabled" : "Auto-assign disabled" });
  };

  // Notify staff member on WhatsApp when a customer is assigned to them
  const notifyStaffAssignment = async (staffUserId: string, row: LeadRow) => {
    try {
      const member = staff.find((s) => s.staff_user_id === staffUserId);
      const number = member?.whatsapp_number?.trim();
      if (!number || !effectiveUserId) return;

      const { data: sessionData } = await supabase
        .from("user_wsender_sessions" as any)
        .select("session_api_key, session_id")
        .eq("user_id", effectiveUserId)
        .limit(1)
        .maybeSingle();

      const displayPhone = String(row.phone_number || "").split("@")[0];
      const loc = row.location || row.district || "Pending capture";
      const pkg = row.package_interest ? `\nInterested In: ${row.package_interest}` : "";
      const message = `👤 NEW LEAD ASSIGNED (Ibbagamuwa Fishing Centre)\n\nName: ${row.customer_name || "Unknown"}\nContact: ${displayPhone}\nLocation: ${loc}${pkg}\n\nPlease follow up with this customer.`;

      await fetch(`${import.meta.env.VITE_SUPABASE_URL}/functions/v1/send-whatsapp-ibbagamuwa`, {
        method: "POST",
        headers: {
          Authorization: `Bearer ${import.meta.env.VITE_SUPABASE_PUBLISHABLE_KEY}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          to: number,
          message,
          sessionApiKey:
            (sessionData as any)?.session_api_key || (sessionData as any)?.session_id,
        }),
      });
    } catch (e) {
      console.error("Staff assignment notification failed", e);
    }
  };

  const updateLead = async (row: LeadRow, patch: Record<string, any>) => {
    if (!row.id) return;
    setRows((prev) => prev.map((r) => (r.id === row.id ? { ...r, ...patch } : r)));
    const { error } = await (supabase.from("leads" as any) as any)
      .update(patch)
      .eq("id", row.id);
    if (error) {
      toast({ title: "Update failed", description: error.message, variant: "destructive" });
      load();
      return;
    }
    if (
      Object.prototype.hasOwnProperty.call(patch, "assigned_to") &&
      patch.assigned_to &&
      patch.assigned_to !== row.assigned_to
    ) {
      notifyStaffAssignment(patch.assigned_to, { ...row, ...patch });
    }
  };

  const staffName = (id: string | null) => {
    if (!id) return "Unassigned";
    const s = staff.find((x) => x.staff_user_id === id);
    return s?.staff_name || s?.staff_email || "Staff";
  };

  // Qualified according to PRD criteria: location captured, status marked, or order placed
  const isQualified = (r: LeadRow) =>
    r.status === "qualified_lead" ||
    Boolean(r.location) ||
    r.status === "cod_confirmed" ||
    r.status === "bank_transfer_pending" ||
    r.has_order;

  // Available unique districts for filtering
  const availableDistricts = useMemo(() => {
    const set = new Set<string>();
    rows.forEach((r) => {
      if (r.district && r.district.trim()) set.add(r.district.trim());
    });
    return Array.from(set).sort();
  }, [rows]);

  const visibleRows = useMemo(() => {
    let list = rows;
    if (isStaff && user) list = list.filter((r) => r.assigned_to === user.id);
    if (search.trim()) {
      const q = search.toLowerCase();
      list = list.filter(
        (r) =>
          r.phone_number.toLowerCase().includes(q) ||
          r.customer_name.toLowerCase().includes(q) ||
          (r.location && r.location.toLowerCase().includes(q)) ||
          (r.district && r.district.toLowerCase().includes(q)) ||
          (r.package_interest && r.package_interest.toLowerCase().includes(q))
      );
    }
    if (isOwner) {
      if (filterStaff !== ALL) {
        list = list.filter((r) =>
          filterStaff === UNASSIGNED ? !r.assigned_to : r.assigned_to === filterStaff
        );
      }
      if (filterStatus !== ALL) list = list.filter((r) => r.status === filterStatus);
      if (filterDistrict !== ALL) list = list.filter((r) => r.district === filterDistrict);
      if (qualifiedOnly) list = list.filter(isQualified);
    }
    return list;
  }, [rows, isStaff, user, search, isOwner, filterStaff, filterStatus, filterDistrict, qualifiedOnly]);

  if (planLoading) {
    return (
      <DashboardLayout>
        <p className="text-muted-foreground">Loading...</p>
      </DashboardLayout>
    );
  }

  if (!isGrowth) {
    return (
      <DashboardLayout>
        <div className="max-w-xl mx-auto mt-10">
          <Card>
            <CardHeader className="text-center">
              <div className="mx-auto h-12 w-12 rounded-full bg-muted flex items-center justify-center mb-2">
                <Lock className="h-6 w-6 text-muted-foreground" />
              </div>
              <CardTitle>Leads is an Enterprise feature</CardTitle>
              <CardDescription>
                Track customer inquiries, capture delivery locations, assign leads to staff, and qualify fishing gear buyers.
              </CardDescription>
            </CardHeader>
            <CardContent className="text-center">
              <Button onClick={() => navigate("/dashboard/settings")}>View plan details</Button>
            </CardContent>
          </Card>
        </div>
      </DashboardLayout>
    );
  }

  return (
    <DashboardLayout>
      <div className="space-y-6">
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
          <div>
            <h1 className="text-2xl sm:text-3xl font-bold tracking-tight">Leads & Location Tracking</h1>
            <p className="text-muted-foreground text-sm">
              {isStaff
                ? "Qualified fishing leads assigned to you"
                : "Identify and filter lead customers with their delivery location (Ibbagamuwa Fishing Centre)"}
            </p>
          </div>
          {isOwner && (
            <div className="flex items-center gap-2 rounded-lg border p-3">
              <Switch
                id="auto-assign"
                checked={autoAssign}
                onCheckedChange={toggleAutoAssign}
                disabled={staff.length === 0}
              />
              <Label htmlFor="auto-assign" className="text-sm cursor-pointer">
                Assign automatically
              </Label>
            </div>
          )}
        </div>

        {/* Filters */}
        <div className="flex flex-wrap gap-2 items-center">
          <div className="relative flex-1 min-w-[200px]">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
            <Input
              placeholder="Search name, phone, location, or package..."
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              className="pl-9"
            />
          </div>
          {isOwner && (
            <>
              <Select value={filterStaff} onValueChange={setFilterStaff}>
                <SelectTrigger className="w-[160px]">
                  <SelectValue placeholder="All staff" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value={ALL}>All staff</SelectItem>
                  <SelectItem value={UNASSIGNED}>Unassigned</SelectItem>
                  {staff.map((s) => (
                    <SelectItem key={s.staff_user_id} value={s.staff_user_id}>
                      {s.staff_name || s.staff_email}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>

              <Select value={filterStatus} onValueChange={setFilterStatus}>
                <SelectTrigger className="w-[190px]">
                  <SelectValue placeholder="All stages" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value={ALL}>All stages</SelectItem>
                  {LEAD_STATUSES.map((s) => (
                    <SelectItem key={s.value} value={s.value}>
                      {s.label}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>

              {availableDistricts.length > 0 && (
                <Select value={filterDistrict} onValueChange={setFilterDistrict}>
                  <SelectTrigger className="w-[160px]">
                    <SelectValue placeholder="All districts" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value={ALL}>All districts</SelectItem>
                    {availableDistricts.map((d) => (
                      <SelectItem key={d} value={d}>
                        {d}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              )}

              <Button
                variant={qualifiedOnly ? "default" : "outline"}
                onClick={() => setQualifiedOnly((v) => !v)}
              >
                <Sparkles className="h-4 w-4 mr-2" />
                Qualified with Location
              </Button>
            </>
          )}
        </div>

        <Card>
          <CardHeader className="pb-3">
            <CardTitle className="flex items-center gap-2 text-lg">
              <Users className="h-5 w-5" />
              {visibleRows.length} lead{visibleRows.length === 1 ? "" : "s"}
            </CardTitle>
          </CardHeader>
          <CardContent>
            {loading ? (
              <p className="text-muted-foreground">Loading...</p>
            ) : visibleRows.length === 0 ? (
              <p className="text-muted-foreground">No leads found.</p>
            ) : (
              <div className="space-y-3">
                {visibleRows.map((row) => {
                  const qualified = isQualified(row);
                  return (
                    <div
                      key={row.phone_number}
                      className={cn(
                        "flex flex-col lg:flex-row lg:items-center gap-3 p-4 rounded-lg border transition-colors",
                        qualified && "border-emerald-500/40 bg-emerald-500/5"
                      )}
                    >
                      <div className="flex-1 min-w-0 space-y-1">
                        <div className="flex items-center gap-2 flex-wrap">
                          <p className="font-semibold truncate text-base">{row.customer_name}</p>
                          {qualified && (
                            <Badge className="bg-emerald-600 hover:bg-emerald-700 text-white text-[11px] font-medium">
                              <Sparkles className="h-3 w-3 mr-1" />
                              Qualified Lead
                            </Badge>
                          )}
                          {row.has_order && (
                            <Badge variant="secondary" className="text-[10px]">
                              Ordered
                            </Badge>
                          )}
                        </div>

                        {/* Customer Location prominently displayed (Main PRD Objective) */}
                        <div className="flex items-center gap-1.5 text-sm font-medium text-foreground flex-wrap">
                          <MapPin className="h-4 w-4 shrink-0 text-rose-500" />
                          {row.location || row.district ? (
                            <span className="text-rose-700 dark:text-rose-400 font-semibold">
                              {row.location ? row.location : `District: ${row.district}`}
                            </span>
                          ) : (
                            <span className="text-muted-foreground text-xs italic">
                              Location pending capture
                            </span>
                          )}
                          {row.district && row.location && !row.location.toLowerCase().includes(row.district.toLowerCase()) && (
                            <Badge variant="outline" className="text-[10px] py-0 px-1.5">
                              {row.district}
                            </Badge>
                          )}
                        </div>

                        {/* Package interest & timeline details */}
                        {row.package_interest && (
                          <div className="flex items-center gap-1.5 text-xs text-muted-foreground">
                            <Package className="h-3.5 w-3.5 shrink-0 text-sky-500" />
                            <span>
                              Package: <strong className="text-foreground">{row.package_interest}</strong>
                              {row.quantity > 1 ? ` (Qty: ${row.quantity})` : ""}
                            </span>
                          </div>
                        )}

                        <div className="flex items-center gap-3 text-xs text-muted-foreground flex-wrap pt-0.5">
                          <span>{row.phone_number}</span>
                          <span>·</span>
                          <span>{row.inbound_count} message{row.inbound_count === 1 ? "" : "s"}</span>
                          {row.purchase_timeline && (
                            <>
                              <span>·</span>
                              <span className="flex items-center gap-1">
                                <Clock className="h-3 w-3" />
                                {row.purchase_timeline}
                              </span>
                            </>
                          )}
                          {row.payment_preference && (
                            <>
                              <span>·</span>
                              <span className="flex items-center gap-1">
                                <CreditCard className="h-3 w-3" />
                                {row.payment_preference === "cod" ? "Cash on Delivery" : "Bank Transfer"}
                              </span>
                            </>
                          )}
                        </div>
                      </div>

                      <div className="flex flex-wrap items-center gap-2 pt-2 lg:pt-0">
                        {isOwner ? (
                          <Select
                            value={row.assigned_to || UNASSIGNED}
                            onValueChange={(v) =>
                              updateLead(row, { assigned_to: v === UNASSIGNED ? null : v })
                            }
                          >
                            <SelectTrigger className="w-[160px]">
                              <SelectValue placeholder="Assign to" />
                            </SelectTrigger>
                            <SelectContent>
                              <SelectItem value={UNASSIGNED}>Unassigned</SelectItem>
                              {staff.map((s) => (
                                <SelectItem key={s.staff_user_id} value={s.staff_user_id}>
                                  {s.staff_name || s.staff_email}
                                </SelectItem>
                              ))}
                            </SelectContent>
                          </Select>
                        ) : (
                          <Badge variant="outline">{staffName(row.assigned_to)}</Badge>
                        )}

                        <Select
                          value={row.status}
                          onValueChange={(v) => updateLead(row, { status: v })}
                        >
                          <SelectTrigger className="w-[170px]">
                            <SelectValue />
                          </SelectTrigger>
                          <SelectContent>
                            {LEAD_STATUSES.map((s) => (
                              <SelectItem key={s.value} value={s.value}>
                                {s.label}
                              </SelectItem>
                            ))}
                          </SelectContent>
                        </Select>

                        <Button
                          variant="outline"
                          size="sm"
                          onClick={() =>
                            navigate(
                              `/dashboard/conversations?phone=${encodeURIComponent(
                                row.phone_number
                              )}`
                            )
                          }
                        >
                          <MessageSquare className="h-4 w-4 mr-2" />
                          Chat
                        </Button>
                      </div>
                    </div>
                  );
                })}
              </div>
            )}
          </CardContent>
        </Card>
      </div>
    </DashboardLayout>
  );
}
