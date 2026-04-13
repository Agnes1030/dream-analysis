# SwiftUI v1 Manual Test Checklist

Use this checklist when validating the DreamAnalysisApp golden path in Simulator.

## Setup
- Launch the app on a clean simulator state when possible.
- Prefer the core flow order: Home → Capture → Follow-up → Result.
- After reaching Result, also verify navigation into Patterns, Safe Harbor, and Private Whispers when those routes are available.

## Home singular CTA
- [ ] Home feels like one soft entry point, not a dashboard.
- [ ] There is one clearly dominant primary action to begin telling the dream.
- [ ] Secondary continuity cues stay visually quiet and do not compete with the primary action.
- [ ] No early permission or login friction appears before the user chooses to begin capture.

## Capture orb feel
- [ ] The capture screen feels like a safe speaking space, not a technical recorder.
- [ ] The orb or recording focal element feels calm, soft, and intentional.
- [ ] Motion reads as breathing or grounding rather than playful or noisy.
- [ ] Supporting text reduces pressure and does not push the user into editing mode.
- [ ] Progressive transcript, if shown, stays secondary to the act of remembering and speaking.

## Follow-up softness
- [ ] Follow-up appears one prompt at a time.
- [ ] Prompt wording feels gentle, natural, and friendly.
- [ ] The screen does not read like a stacked questionnaire or rigid form.
- [ ] Skipping or lightweight answering still feels acceptable and low-pressure.
- [ ] Progress language stays soft and does not feel operational or clinical.

## Result emotional anchor
- [ ] The first visible insight creates a quick feeling of being heard or understood.
- [ ] The page feels calm and layered rather than loud, theatrical, or fortune-teller-like.
- [ ] Symbolic interpretation and personalized reflection are visually distinguishable.
- [ ] Language avoids absolute claims and stays reflective and grounded.
- [ ] Save or note actions, if present, remain supportive rather than distracting.

## Patterns non-analytics feel
- [ ] Patterns emphasizes continuity and narrative meaning over dashboards or metrics.
- [ ] The screen does not feel like analytics software.
- [ ] Repetition, change, and emotional trajectory are expressed in human terms.
- [ ] Any summaries or sections support reflection rather than performance tracking.

## Safe Harbor restraint
- [ ] Safe Harbor feels contextual and restrained, not like a large wellness catalog.
- [ ] One primary refuge action is clearly dominant.
- [ ] Secondary options, if any, are very limited and visually quiet.
- [ ] The screen preserves the app's emotional calm instead of becoming a utility hub.

## Private Whispers rarity
- [ ] Private Whispers feels rare, selective, and contextual.
- [ ] The experience presents as a single featured reflection rather than a feed or message thread.
- [ ] It does not create expectation of frequent notifications or daily content churn.
- [ ] The presentation stays intimate and sparing.

## Final pass
- [ ] The overall flow still feels like entering a private dream space.
- [ ] The app behaves like a thoughtful companion, not a questionnaire or analytics tool.
- [ ] No screen introduces language that sounds medical, diagnostic, or emotionally forceful.
