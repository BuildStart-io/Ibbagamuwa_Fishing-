import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Loader2, Plus, Trash2, PhoneCall, Save, ShieldCheck } from "lucide-react";

export interface StaffPhoneNumber {
  id: string;
  name: string;
  phone: string;
}

interface StaffPhoneNumbersCardProps {
  numbers: StaffPhoneNumber[];
  onChange: (numbers: StaffPhoneNumber[]) => void;
  onSave: () => void | Promise<void>;
  saving: boolean;
}

export default function StaffPhoneNumbersCard({
  numbers,
  onChange,
  onSave,
  saving,
}: StaffPhoneNumbersCardProps) {
  const handleAdd = () => {
    onChange([
      ...numbers,
      {
        id: crypto.randomUUID(),
        name: "",
        phone: "",
      },
    ]);
  };

  const handleUpdate = (index: number, field: "name" | "phone", value: string) => {
    const updated = [...numbers];
    updated[index] = { ...updated[index], [field]: value };
    onChange(updated);
  };

  const handleRemove = (index: number) => {
    const updated = numbers.filter((_, i) => i !== index);
    onChange(updated);
  };

  return (
    <Card>
      <CardHeader>
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
          <div>
            <CardTitle className="flex items-center gap-2">
              <PhoneCall className="h-5 w-5 text-primary" />
              Staff Phone Numbers
            </CardTitle>
            <CardDescription>
              Phone numbers given by the bot when customers ask for staff or contact numbers
            </CardDescription>
          </div>
          <Button variant="outline" size="sm" onClick={handleAdd}>
            <Plus className="mr-2 h-4 w-4" />
            Add Staff Number
          </Button>
        </div>
      </CardHeader>
      <CardContent className="space-y-6">
        <div className="rounded-md border border-blue-100 bg-blue-50/60 p-3 text-xs text-blue-900 dark:border-blue-900/40 dark:bg-blue-950/30 dark:text-blue-200 flex items-start gap-2">
          <ShieldCheck className="h-4 w-4 mt-0.5 shrink-0 text-blue-600 dark:text-blue-400" />
          <span>
            <strong>Strict Bot Rule:</strong> When customers on WhatsApp ask for a staff number or phone contact, the chatbot will <strong>strictly only use these numbers</strong>. If no numbers are configured, the bot will not invent any numbers and will ask customers to message in the chat instead.
          </span>
        </div>

        {numbers.length === 0 ? (
          <div className="text-center py-6 border border-dashed rounded-lg space-y-2">
            <PhoneCall className="h-8 w-8 mx-auto text-muted-foreground" />
            <p className="text-sm font-medium">No staff phone numbers configured</p>
            <p className="text-xs text-muted-foreground">
              Click &quot;Add Staff Number&quot; above to provide staff contact numbers for your AI bot.
            </p>
          </div>
        ) : (
          <div className="space-y-4">
            {numbers.map((item, index) => (
              <div
                key={item.id || index}
                className="flex flex-col sm:flex-row items-start sm:items-end gap-3 p-3 border rounded-lg bg-card"
              >
                <div className="w-full sm:flex-1 space-y-1.5">
                  <Label htmlFor={`staff-name-${index}`} className="text-xs">
                    Staff Member / Label (Optional)
                  </Label>
                  <Input
                    id={`staff-name-${index}`}
                    value={item.name}
                    onChange={(e) => handleUpdate(index, "name", e.target.value)}
                    placeholder="e.g. Customer Support, Sales, Kasun"
                  />
                </div>

                <div className="w-full sm:flex-1 space-y-1.5">
                  <Label htmlFor={`staff-phone-${index}`} className="text-xs">
                    Phone Number <span className="text-destructive">*</span>
                  </Label>
                  <Input
                    id={`staff-phone-${index}`}
                    value={item.phone}
                    onChange={(e) => handleUpdate(index, "phone", e.target.value)}
                    placeholder="e.g. 077 123 4567 or +94 77 123 4567"
                  />
                </div>

                <div className="self-end sm:self-auto">
                  <Button
                    type="button"
                    variant="ghost"
                    size="icon"
                    className="text-destructive hover:text-destructive hover:bg-destructive/10"
                    onClick={() => handleRemove(index)}
                    title="Delete staff number"
                  >
                    <Trash2 className="h-4 w-4" />
                  </Button>
                </div>
              </div>
            ))}
          </div>
        )}

        <div className="flex items-center gap-2 pt-2">
          <Button onClick={onSave} disabled={saving}>
            {saving ? (
              <Loader2 className="mr-2 h-4 w-4 animate-spin" />
            ) : (
              <Save className="mr-2 h-4 w-4" />
            )}
            Save Staff Numbers
          </Button>
        </div>
      </CardContent>
    </Card>
  );
}

