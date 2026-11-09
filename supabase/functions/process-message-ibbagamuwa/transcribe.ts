function bytesToBase64(bytes: Uint8Array): string {
  let binary = "";
  for (let offset = 0; offset < bytes.length; offset += 8192) {
    binary += String.fromCharCode(...bytes.subarray(offset, offset + 8192));
  }
  return btoa(binary);
}

export async function transcribeAudio(
  sessionName: string,
  wahaMessageId: string,
  mediaUrl?: string,
  mimeType?: string
): Promise<string | null> {
  const WAHA_BASE = (Deno.env.get("WAHA_BASE_URL") || "").replace(/\/+$/, "");
  const WAHA_KEY = Deno.env.get("WAHA_API_KEY") || "";
  const OPENROUTER_API_KEY = Deno.env.get("OPENROUTER_API_KEY") || "";

  if (!OPENROUTER_API_KEY) {
    console.error("OPENROUTER_API_KEY is not configured.");
    return null;
  }

  // 1. Download WAHA Audio
  let audioBuffer: Uint8Array;
  try {
    const rawUrl = mediaUrl || `${WAHA_BASE}/api/${encodeURIComponent(sessionName)}/messages/${encodeURIComponent(wahaMessageId)}/download`;
    const wahaUrl = rawUrl.replace(/^https?:\/\/(?:localhost|127\.0\.0\.1):3000\b/i, WAHA_BASE || "http://waha:3000");
    console.log(`Downloading audio from: ${wahaUrl}`);
    const res = await fetch(wahaUrl, {
      headers: { "X-Api-Key": WAHA_KEY, "Accept": "*/*" },
      signal: AbortSignal.timeout(15_000)
    });

    if (!res.ok) {
      console.error(`WAHA download failed (${res.status}): ${await res.text()}`);
      return null;
    }

    audioBuffer = new Uint8Array(await res.arrayBuffer());
    console.log(`Downloaded ${audioBuffer.length} bytes of audio data`);
  } catch (err) {
    console.error("Error downloading audio from WAHA:", err);
    return null;
  }

  const cleanMime = (mimeType || "audio/ogg").split(";")[0].trim() || "audio/ogg";
  const base64Audio = bytesToBase64(audioBuffer);
  const dataUrl = `data:${cleanMime};base64,${base64Audio}`;

  const prompt = "You are an expert speech-to-text transcriber for WhatsApp voice messages in Sri Lanka. Transcribe the spoken audio verbatim in its native language and script (Tamil script for Tamil, Sinhala script for Sinhala, Latin script for English/Singlish). Output ONLY the exact transcribed words without quotes, preamble, formatting, or commentary. If the audio has no speech or is unintelligible noise, output [UNINTELLIGIBLE].";

  // 2. Direct Multimodal Audio Transcription via OpenRouter Gemini
  const models = ["google/gemini-2.5-flash", "google/gemini-2.0-flash-001"];
  for (const model of models) {
    try {
      console.log(`Transcribing audio using OpenRouter (${model})...`);
      const orRes = await fetch("https://openrouter.ai/api/v1/chat/completions", {
        method: "POST",
        headers: {
          "Authorization": `Bearer ${OPENROUTER_API_KEY}`,
          "Content-Type": "application/json"
        },
        body: JSON.stringify({
          model: model,
          max_tokens: 300,
          messages: [
            {
              role: "user",
              content: [
                {
                  type: "text",
                  text: prompt
                },
                {
                  type: "image_url",
                  image_url: {
                    url: dataUrl
                  }
                }
              ]
            }
          ]
        }),
        signal: AbortSignal.timeout(25_000)
      });

      if (orRes.ok) {
        const orData = await orRes.json();
        let transcription = orData?.choices?.[0]?.message?.content?.trim();
        transcription = (transcription || "").replace(/^["'`]+|["'`]+$/g, "").trim();
        if (transcription && transcription !== "[UNINTELLIGIBLE]") {
          console.log(`OpenRouter (${model}) transcription successful:`, transcription);
          return transcription;
        }
      } else {
        console.warn(`OpenRouter (${model}) failed (${orRes.status}): ${await orRes.text()}`);
      }
    } catch (err) {
      console.error(`Error transcribing audio via OpenRouter (${model}):`, err);
    }
  }

  return null;
}
