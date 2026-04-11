# Dream Analysis iOS App

## Project Status
- Stage: product definition
- Platform: iOS
- Core concept: voice-first dream journaling + personalized dream interpretation

## Product Direction
- Product type: hybrid dream interpretation app with a psychological companionship core
- Personalization model: dual-engine personalization
  - remembers dream patterns, symbols, people, places, and recurring scenes
  - builds an evolving emotional / psychological profile from repeated use
- Primary experience flow: record dream → gentle follow-up → interpretation
- Interpretation style: dual-layer output
  - layer 1: symbolic dream interpretation
  - layer 2: personalized psychological reflection and gentle suggestions

## Experience Principles
- Follow-up prompts must feel gentle, natural, and friendly
- Avoid rigid, form-like, or interrogative wording
- The app should feel like a thoughtful companion, not a questionnaire
- The product should not position itself as a medical or diagnostic tool

## Product Structure
- Core screens for v1:
  1. Home / today entry
  2. Dream capture
  3. Gentle follow-up
  4. Interpretation result
  5. Dream archive / personal pattern view
- Core loop: record one dream → receive one interpretation → accumulate long-term pattern memory → improve future interpretations
- Avoid for v1: community features, social sharing systems, expert consultation flows, heavy psychological assessment tooling

## AI Capability Design
- Step 1: voice capture
  - user speaks naturally about the dream
  - system converts speech to text
- Step 2: dream understanding
  - extract dream entities: people, places, objects, events, recurring symbols
  - extract emotional cues: fear, relief, confusion, longing, stress, safety, etc.
- Step 3: gentle contextual follow-up
  - generate 2-4 soft follow-up prompts
  - fill in the most useful missing context without sounding like a form
- Step 4: layered interpretation generation
  - layer 1: symbolic / imagery-based dream interpretation
  - layer 2: personalized reflection based on recent dream history and emotional patterns
- Step 5: memory update
  - store new dream motifs, recurring people / locations / symbols, emotional tone, and inferred themes
  - update the user's evolving dream profile and emotional profile
- Step 6: long-term personalization
  - future interpretations should reference repetition, change, and continuity across prior dreams
  - product value should increase with repeated use instead of resetting every session

## iOS v1 Technical Recommendation
- App framework: SwiftUI for the iOS client
- Local persistence: SwiftData or Core Data for dream records, extracted symbols, emotional signals, and user profile summaries
- Voice input: native Apple speech stack first for v1, with room to swap to a higher-accuracy cloud transcription service later if needed
- Backend approach for v1: lightweight cloud backend for AI interpretation and profile updating
- Architecture direction: hybrid
  - on-device stores private dream history and recent user state
  - cloud AI handles interpretation, structured extraction, memory summarization, and personalization logic
- Why hybrid for v1:
  - gives better AI quality and iteration speed than fully on-device
  - preserves a path to stronger privacy controls and partial offline behavior

## Technical System Flow
1. User records a dream in the iOS app.
2. Speech is transcribed into text.
3. App sends the dream text plus selected recent memory context to an AI backend.
4. Backend returns:
   - structured dream extraction
   - gentle follow-up prompts
   - final layered interpretation
   - memory update payloads
5. App stores the new dream, interpretation, and updated profile summary.
6. Future sessions use stored memory summaries to personalize the next interpretation.

## Data Model Direction
- Dream record
  - original transcript
  - cleaned transcript
  - dream timestamp
  - emotional tone
  - extracted symbols
  - extracted people / places / events
  - final interpretation
- User dream memory
  - recurring symbols
  - recurring people / locations
  - repeated themes
  - dream frequency and recent changes
- User emotional profile
  - recurring emotions
  - inferred stress / safety / attachment patterns
  - short-term and long-term trend summaries

## Data Strategy
- Chosen direction: hybrid data strategy
- Raw dream content should stay as local-first as possible to preserve privacy and emotional safety
- AI interpretation, memory summarization, and personalization updates can use cloud processing
- The app should send only the context needed for high-quality interpretation and evolving memory
- Architecture goal: preserve the feeling of a private journal while still benefiting from strong cloud AI

## Privacy Direction
- Position the product as private and emotionally safe, not as a public social product
- Be explicit about what stays on-device, what is uploaded, and why
- Give users understandable control over memory and history in later versions

## v1 Release Scope
- Chosen release style: more complete v1 release
- v1 should include:
  - dream recording
  - gentle follow-up
  - layered interpretation
  - dream history
  - personal pattern summaries
  - login
  - cloud sync
  - richer profile / pattern presentation
- Product goal for v1: feel like a real, polished consumer app rather than an internal prototype
- Risk note: richer v1 scope increases build complexity, so architecture should separate core dream loop from account/sync concerns

## Product Priorities for v1
1. Make the first dream capture and interpretation feel emotionally compelling.
2. Make repeated use clearly improve personalization quality.
3. Make account and sync invisible and low-friction.
4. Make profile / pattern views feel meaningful, not just decorative analytics.

## Onboarding Strategy
- Chosen direction: experience first, login later
- New users should be able to complete an initial dream capture and receive value before being asked to create an account
- Login should be introduced at the moment of clear user benefit, such as saving history, syncing across devices, or preserving a growing personal dream profile
- The first session should optimize for emotional entry and trust, not account conversion friction

## Account Strategy
- Authentication is a product infrastructure layer, not the emotional entry point
- Registration prompts should be framed around continuity and memory preservation, not platform requirements
- Example value framing:
  - save this dream to your archive
  - keep your growing dream profile
  - sync your dream history across devices

## Visual Direction
- Chosen visual tone: light luxury spirituality
- Desired feeling:
  - premium
  - dreamy
  - feminine-leaning but not childish
  - mystical without looking cheap or overly occult
  - emotionally warm and refined
- Visual design implications:
  - elegant gradients
  - soft glow / haze / moonlight-inspired depth
  - restrained symbolic elements
  - fine typography and generous spacing
  - polished motion rather than playful gimmicks

## Brand Feeling
- The app should feel like a private, beautiful dream space
- It should sit between a dream ritual product and a high-end emotional wellness app
- The interface should create trust and desire, not just utility

## User Journey
- The product should feel like entering a private dream space, not operating a utility app
- First-session goal:
  - emotionally receive the user
  - make it easy to start speaking about a dream
  - deliver a compelling first interpretation before asking for commitment
- Returning-user goal:
  - create continuity
  - show the user that the app remembers recurring symbols, feelings, and themes
  - deepen the sense that interpretation quality improves over time
- Emotional progression:
  1. curiosity / emotional openness
  2. feeling heard
  3. feeling understood
  4. wanting to preserve and revisit insights
  5. trusting the app as a long-term reflective companion

## First Open Experience
- Do not overwhelm the first session with tutorials, forms, or early registration friction
- The homepage should lead naturally to one action: begin telling the dream
- The post-recording experience should feel listened to rather than mechanically processed
- Login should appear only after the user has experienced value

## Home Experience
- The home screen should feel like a soft dream entry point, not a dashboard full of modules
- Visual hierarchy:
  1. atmosphere and brand feeling
  2. one clear primary action: start telling the dream
  3. light continuity cues for returning users
- Home content principles:
  - keep information density low
  - prioritize emotional invitation over product explanation
  - show memory / continuity in subtle ways
- Example returning-user cues:
  - recurring symbols
  - recent emotional themes
  - a short callback to the previous dream or interpretation

## Permission Strategy
- Do not front-load permissions on app launch
- Request microphone permission only when the user actively starts dream capture
- Do not request login or sync before the user experiences core value
- Protect the emotional flow of the first session from system friction

## Dream Capture Experience
- The capture screen should feel like a safe speaking space, not a technical recording utility
- Recording UI principles:
  - one clear recording state
  - soft motion and breathing feedback
  - low-pressure language
  - minimal text competition while the user is remembering the dream
- Guidance tone example:
  - encourage natural recall
  - reduce fear of forgetting details or speaking imperfectly
- Real-time transcription can appear progressively, but should not dominate attention or push the user into editing mode too early

## Gentle Follow-up Experience
- The transition after recording should feel like the system is listening and organizing, not mechanically processing
- Follow-up format should be one prompt at a time, not a stacked questionnaire
- Response types can be mixed:
  - simple tap choices
  - short text reply
  - lightweight sliders or emotion selections if presented softly
- Follow-up principles:
  - ask only what most improves interpretation quality
  - avoid asking the maximum number of questions by default
  - keep the conversation feeling warm and responsive
- Suggested follow-up count for v1: 2-4, but fewer when sufficient context already exists

## Interpretation Result Experience
- The result screen should feel layered, calm, and emotionally intelligent rather than loud or mystical-for-effect
- Recommended structure:
  1. a short core insight that immediately makes the user feel understood
  2. symbolic dream interpretation layer
  3. personalized state / reflection layer tied to recent patterns
- Tone principles:
  - avoid absolute claims
  - prefer reflective, grounded language
  - sound insightful without sounding theatrical or fortune-teller-like
- Product behavior:
  - create a feeling that the app understood this dream in the context of the user's ongoing inner life
  - offer lightweight ways to preserve the insight or save a personal note

## Dream Archive Experience
- The archive should be more than a chronological list of dream entries
- It should help users see continuity and pattern over time
- Archive value layers:
  - individual dream records
  - recurring symbols
  - repeated people / places
  - emotional trends
  - stage-based themes and repeated motifs
- Design goal:
  - help the user feel that their dreams are connected and meaningful over time
  - turn the archive into a long-term reflection product, not just storage

## Content Style System
- Writing tone should be:
  - gentle
  - restrained
  - emotionally warm
  - reflective
  - slightly mysterious, but grounded
- The app should never sound:
  - commanding
  - overly clinical
  - cheap-mystical
  - exaggerated or absolute
  - salesy or growth-hacky

## Content Guidance by Context
- Home:
  - inviting, soft, low-pressure
  - speak like welcoming the user into a private space
- Capture:
  - reduce performance pressure
  - reassure the user they can speak imperfectly
- Follow-up:
  - sound like natural continuation, not form completion
- Interpretation:
  - use reflective language instead of fixed judgment
  - sound insightful without pretending certainty
- Login / save prompts:
  - frame around continuity, memory, and preserving insight
  - avoid aggressive conversion language

## Expressions to Avoid
- avoid certainty language such as:
  - you definitely are...
  - this proves...
  - your subconscious is warning you...
- avoid mechanical product language such as:
  - please complete the following
  - select an option
  - start recording content
- avoid hard conversion language such as:
  - unlock now
  - register immediately
  - complete setup to continue

## Information Architecture
- Recommended top-level structure for v1:
  1. Home
  2. Dream Flow
  3. Archive
  4. Profile / Patterns
- Rationale:
  - Home creates emotional entry
  - Dream Flow delivers the core loop
  - Archive supports memory and revisit behavior
  - Profile / Patterns makes long-term personalization visible

## Sitemap Details
- Home
  - start dream capture
  - recent dream callback
  - recurring symbols / emotion cues
  - link to archive or pattern view
- Dream Flow
  - recording state
  - live transcription state
  - transition / processing state
  - gentle follow-up
  - interpretation result
- Archive
  - dream timeline
  - dream detail page
  - optional light search / tags later
- Profile / Patterns
  - recurring symbols
  - recurring people / places
  - emotional trend summaries
  - personal dream profile summary
  - account / sync settings
  - privacy / memory controls

## Page Function Breakdown
- Home
  - goal: start the dream journey naturally and reinforce continuity
  - must-have:
    - primary dream capture CTA
    - short home guidance copy
    - recent dream callback
    - recurring symbol / emotion hints
    - entry to archive and profile / patterns
  - not required for v1:
    - heavy recommendation feeds
    - community content
    - dense analytics cards
- Dream Capture
  - goal: reduce friction and help the user tell the dream fully
  - must-have:
    - start / pause / end recording
    - soft recording feedback
    - live transcription
    - simple post-recording confirmation
    - lightweight text correction if needed
  - not required for v1:
    - advanced audio editing
    - multi-track audio features
    - ritual sound systems
- Gentle Follow-up
  - goal: collect only the most valuable missing context
  - must-have:
    - one-question-at-a-time flow
    - skipable prompts
    - soft response controls
    - strict question count control
  - not required for v1:
    - deep branching counseling logic
    - long questionnaires
- Interpretation Result
  - goal: deliver emotional and symbolic value in a believable, elevated way
  - must-have:
    - core insight line
    - symbolic interpretation layer
    - personalized reflection layer
    - save / revisit entry points
    - natural login prompt only when useful
  - not required for v1:
    - diagnostic scoring
    - oversized reports
    - fate-prediction style content
- Archive
  - goal: help users revisit dreams simply and meaningfully
  - must-have:
    - timeline list
    - dream detail page
    - tags / emotional markers / dates
  - not required for v1:
    - heavy search tooling
    - advanced filtering systems
    - social sharing systems
- Profile / Patterns
  - goal: make long-term personalization visible and valuable
  - must-have:
    - recurring symbols
    - repeated people / places
    - recent theme summary
    - emotional trend summary
    - login / sync / privacy entry points
  - not required for v1:
    - dense dashboards
    - formal psychological measurements
    - gamified progression systems

## Core User Flows
- Flow 1: first-time user
  - open app
  - see soft home entry
  - start dream capture
  - grant microphone permission when needed
  - record dream
  - answer gentle follow-up
  - receive interpretation
  - see save / login value prompt after value is delivered
- Flow 2: returning user
  - open app
  - see recent continuity cues
  - start another dream capture
  - receive fewer, more targeted follow-up prompts
  - receive interpretation that references recurring patterns when relevant
- Flow 3: post-result save / login
  - user finishes reading interpretation
  - user chooses save, archive, or sync-related action
  - lightweight login appears as continuity infrastructure
  - after login, dream is immediately saved and the benefit is made visible

## Flow Principles
- Deliver understanding before requesting commitment
- Treat login as a continuation mechanism, not a gate
- Show that personalization deepens over repeated use
- Keep every conversion moment tied to preserved value, not platform demand

## Conversion and Retention Design
- Conversion should always follow delivered value, never precede it
- Key conversion moments:
  1. after reading an interpretation and wanting to save it
  2. after repeated use when continuity becomes meaningful
  3. inside profile / pattern views when the user sees an emerging personal trajectory
- Save / login prompts should be framed as preserving continuity, not unlocking generic features
- Sync prompts should emphasize protecting dream history and the evolving personal profile
- The strongest retention mechanism is not a modal, but the user's felt sense that the app remembers them and is becoming more personally relevant

## Retention Principles
- The app should surface continuity cues on return visits
- Pattern recognition should feel earned, not fabricated
- Re-engagement should come from emotional resonance and self-recognition, not notification pressure alone
- Preserve trust by making memory references accurate and contextually grounded

## Product Risks to Avoid
- Avoid looking like a low-trust mystical app
  - mystery should live in atmosphere, not exaggerated claims
- Avoid feeling like a psychological questionnaire tool
  - too much structured questioning breaks the dream narrative feeling
- Avoid resembling a generic AI wrapper
  - long-term memory and continuity must be visible and real
- Avoid fake personalization
  - memory references must be earned and grounded in actual prior data
- Avoid overloading v1
  - too many systems at once will weaken the core experience
- Avoid weak privacy trust
  - users must feel emotionally and technically safe

## Product Definition Summary
- This is an iOS-first dream interpretation app with a psychological companionship core.
- The product experience should feel like entering a private, beautiful dream space.
- Core loop:
  1. user speaks a dream
  2. app gently fills in missing context
  3. app delivers layered interpretation
  4. app remembers patterns over time
  5. future interpretations become more personal and relevant
- The product's differentiation comes from continuity, emotional tone, and believable memory — not from generic AI output alone.
- v1 should already feel like a polished consumer product, while staying disciplined about what is truly essential.

## Next Definition Areas
- example homepage copy and voice
- example follow-up question bank
- example interpretation output structure
- profile / patterns page narrative design
- login and save prompt copy system

## AI Output Specification
- The AI layer should produce structured outputs, not only long-form prose
- Recommended output groups for each dream session:
  1. extracted dream structure
  2. follow-up prompt candidates
  3. final interpretation payload
  4. memory update payload
- Product requirement: UI-visible text should be generated from controlled sections with clear tone constraints

## Dream Structure Output
- Should extract:
  - key people
  - key places
  - key objects / symbols
  - major actions or scene changes
  - explicit emotions
  - likely implicit emotional tone
  - uncertainty markers when the dream is ambiguous
- Extraction should favor clarity and usefulness over over-interpretation

## Follow-up Output Rules
- Generate only the questions that most improve interpretation quality
- Question targets may include:
  - strongest remembered moment
  - wake-up feeling
  - emotional residue after the dream
  - whether this feeling or symbol has appeared recently
- Follow-up output should include:
  - question text
  - question type
  - why this question is being asked internally
  - whether the question is optional / skippable
- Hard rule:
  - never generate cold, form-like, or interrogative wording for user-facing prompts

## Interpretation Output Structure
- Recommended sections:
  1. core insight
  2. symbolic interpretation
  3. personalized reflection
  4. gentle suggestion or reflective close
- Core insight:
  - 1-2 short sentences
  - should make the user feel immediately understood
- Symbolic interpretation:
  - explain the most meaningful dream elements
  - avoid absolute symbolic certainty
- Personalized reflection:
  - connect the dream to recent patterns only when evidence exists
  - reference continuity carefully and specifically
- Gentle suggestion / close:
  - optional, light, and non-prescriptive
  - may invite noticing, rest, or reflection rather than instruction

## Personalization Rules
- Only reference recurring patterns when evidence is strong enough
- Prefer precise wording such as:
  - this feels close to...
  - this echoes...
  - this seems related to...
- Avoid inflated memory claims such as:
  - you always...
  - you keep doing this...
  - this proves a pattern unless repeated evidence exists
- If continuity evidence is weak, stay with the current dream instead of forcing long-term interpretation

## Safety and Trust Rules
- Do not present the app as diagnosing mental illness or psychological conditions
- Do not present speculative interpretation as fact
- Do not intensify fear with alarming claims
- Do not imply supernatural certainty
- When uncertainty exists, the response should remain calm and reflective rather than evasive or dramatic

## Memory Update Payload Rules
- After each interpreted dream, update memory in structured form:
  - recurring symbols candidates
  - recurring people / places candidates
  - emotional signal summary
  - possible theme summary
  - confidence level for each longer-term inference
- Memory should store both content and confidence, so future UI language can stay honest
- Long-term profile summaries should be derived from repeated evidence, not single-session extrapolation

## Memory System Design
- The product should maintain two linked but distinct memory layers:
  1. dream memory
  2. emotional / psychological profile memory
- Dream memory answers: what keeps appearing?
- Emotional profile memory answers: what inner state patterns seem to be emerging?
- These layers should influence interpretation differently and should not be merged into one vague summary blob

## Dream Memory Layer
- Stores recurring content-level elements such as:
  - symbols
  - objects
  - people
  - places
  - repeated scene patterns
  - recurring actions or situations
- For each memory item, store:
  - label
  - normalized canonical form
  - evidence count
  - last seen timestamp
  - recency weight
  - confidence level
  - example dream references
- Purpose:
  - support continuity in interpretation
  - support archive and pattern UI
  - identify meaningful repetition without overclaiming significance

## Emotional Profile Layer
- Stores repeated feeling and theme signals such as:
  - anxiety / pressure
  - avoidance / searching
  - relief / safety
  - longing / attachment
  - confusion / loss of control
  - transition / uncertainty themes
- For each signal, store:
  - signal label
  - evidence count
  - time horizon (recent vs long-term)
  - confidence level
  - trend direction when available
  - supporting dream references
- Purpose:
  - make personalized reflection more grounded
  - help the app identify emotional continuity without diagnosing the user

## Session Memory vs Long-Term Memory
- Session memory
  - temporary context from the current dream and immediate follow-up
  - used to produce a coherent current interpretation
- Long-term memory
  - compressed, confidence-aware summaries derived from repeated dreams
  - used to influence future interpretations and profile surfaces
- Rule:
  - one dream can create candidates, but repeated dreams should be required before promoting many items into strong long-term memory

## Memory Confidence Model
- Every reusable memory item should carry confidence metadata
- Suggested confidence tiers:
  - low: single weak signal or ambiguous mention
  - medium: repeated or clearer evidence
  - high: stable repeated evidence across time
- UI and AI should use confidence-aware phrasing
  - low confidence → do not present as an established pattern
  - medium confidence → present softly
  - high confidence → safe to reference as recurring when context fits

## Memory Use in Product Surfaces
- Home
  - show only stable and emotionally safe continuity cues
- Follow-up generation
  - use memory to avoid asking redundant questions and to ask better ones
- Interpretation
  - use memory to contextualize only when evidence is strong enough
- Archive / Patterns
  - surface recurring symbols, themes, and emotional trends with clear grounding
- Login / sync prompts
  - frame memory as something worth preserving over time

## Memory Integrity Rules
- Never fabricate recurrence from a single dream
- Never collapse multiple distinct symbols into one pattern without enough evidence
- Never let emotional profile labels become clinical diagnoses
- Never over-reference old memory when the current dream strongly differs in tone or content
- Memory should support interpretation, not dominate it

## Memory Progression Design
- The memory system should visibly evolve with user usage, not feel fully formed from day one
- Suggested progression stages:
  1. first sessions: mostly current-dream understanding, minimal historical references
  2. early repeat usage: soft recurring cues begin to appear
  3. established usage: archive and profile views show stronger pattern summaries
  4. mature usage: interpretations can meaningfully compare change over time
- Product goal:
  - users should feel that the app is gradually getting to know them
  - growth in memory should feel earned, subtle, and trustworthy

## Memory Visibility Rules
- Not all stored memory should be shown directly to the user
- Show only memory items that are:
  - stable enough
  - emotionally safe to surface
  - phrased in a helpful and non-alarming way
- Internal memory may be richer than UI-visible memory
- UI memory surfaces should prioritize clarity, calmness, and trust over exhaustiveness

## User Control Over Memory
- The product should eventually give users understandable control over memory and history
- Control directions should include:
  - delete one dream
  - clear saved history
  - remove a specific recurring pattern if needed
  - understand what is stored locally vs in the cloud
- Controls should feel human-readable, not developer-facing
- The product should avoid making memory feel opaque or irreversible

## Memory Explanation Strategy
- The app should be able to explain memory in simple terms
- Example framing:
  - I keep track of recurring images and feelings to make future interpretations more personal
  - I only reference patterns when they show up more than once or feel clearly connected
- Explanation should increase trust and reduce the feeling of hidden profiling

## Follow-up System Design
- The follow-up system should feel like gentle clarification, not information extraction
- Its purpose is to improve interpretation quality with minimal friction
- The system should ask fewer questions, but better ones
- It should know when not to ask

## Follow-up Categories
- Category 1: emotional clarification
  - used when the dream narrative is vivid but the feeling state is unclear
  - example target: how the user felt during or after the dream
- Category 2: focal moment clarification
  - used when the dream contains many scenes and the emotionally dominant moment is unclear
  - example target: which image or moment stayed with the user most strongly
- Category 3: recurrence clarification
  - used only when there is a possible link to prior symbols or feelings and confirmation would improve personalization
  - example target: whether the user has felt or seen something similar recently
- Category 4: relational context clarification
  - used when a dream centers on a specific person or relationship but the emotional meaning is ambiguous
  - example target: what that person or presence felt like in the dream

## Follow-up Trigger Rules
- Ask only when the answer will materially improve interpretation quality
- Avoid asking when:
  - the dream already contains clear emotional and symbolic structure
  - the likely answer would add little interpretive value
  - the question would feel repetitive given known memory
- Prefer 1-2 excellent questions over 4 mediocre ones
- Some dreams may need zero follow-up if the narrative is already sufficiently rich

## Follow-up Writing Principles
- Questions should sound like gentle continuation, not survey prompts
- Good qualities:
  - soft
  - specific
  - easy to answer
  - emotionally safe
- Avoid:
  - clinical phrasing
  - direct interrogation tone
  - abstract or overly intellectual wording
  - stacked multi-part questions
- Preferred question pattern:
  - invite, focus, reassure

## Follow-up Interaction Rules
- Show one question at a time
- Always allow skip
- Keep choice sets small and emotionally readable
- If using text input, keep it optional and short
- The UI should preserve a sense of calm progression rather than task completion

## Questions to Avoid
- Avoid questions that feel diagnostic
- Avoid questions that ask the user to over-analyze themselves too early
- Avoid questions with hidden assumptions, such as implying trauma, warning, or pathology
- Avoid asking for excessive factual detail that does not improve the interpretation

## Sample Output Flows
- The product definition should be validated through representative sample flows
- Sample flows should test:
  - whether the capture feels natural
  - whether follow-up questions sound human and useful
  - whether the interpretation feels elevated rather than generic
  - whether memory references feel earned

## Sample Flow A: first-session dream
- User dream input:
  - I dreamed I was back in my old school, but it was flooded. I kept trying to find my classroom and everyone else seemed to know where to go except me. I woke up feeling really tired.
- Example follow-up:
  - If you keep just one feeling from that dream, would it be closer to慌乱、孤单，还是疲惫？
  - The flooded school image feels very strong. Was there a moment in that scene that stayed with you the most?
- Example interpretation shape:
  - Core insight:
    - This dream seems to hold a strong feeling of being left alone inside something that should have felt familiar.
  - Symbolic layer:
    - A school often relates to growth, evaluation, and older versions of the self. Flooding can make a familiar place feel unsteady, as if emotion has overflowed into something structured.
  - Personalized reflection:
    - Because this is still early, the reflection should stay close to the current dream rather than claiming a larger pattern. It may be reflecting a recent sense of pressure, disorientation, or emotional overload.
  - Gentle close:
    - You do not need to resolve it all at once. It may be enough just to notice where life has felt familiar on the outside, but harder to move through inside.

## Sample Flow B: repeat-user dream with earned continuity
- Context:
  - prior dreams already include water imagery and repeated searching themes with medium confidence
- User dream input:
  - I was standing at a station waiting for someone, and the tracks slowly turned into water. I knew I should leave, but I kept waiting.
- Example follow-up:
  - This dream feels quieter than urgent. When you were waiting there, did it feel more like hope, hesitation, or sadness?
- Example interpretation shape:
  - Core insight:
    - This dream feels less like sudden fear and more like staying inside an uncertainty that has already lasted a while.
  - Symbolic layer:
    - Stations often carry the feeling of transition, timing, and missed movement. Water here softens the scene, but also removes solid direction.
  - Personalized reflection:
    - Water and waiting have both appeared in your recent dreams before, so this may be part of a repeating theme around uncertainty and emotional suspension. Compared with earlier dreams, this one feels less chaotic and more resigned.
  - Gentle close:
    - It may be worth noticing whether there is something in waking life you have been emotionally waiting on, even if you already sense it is changing shape.

## Sample Flow C: what to avoid
- Bad follow-up example:
  - Select your emotional state.
  - Did you experience trauma, anxiety, attachment disturbance, or dissociation?
- Bad interpretation example:
  - Your subconscious is warning you that disaster is coming.
  - This proves you have deep unresolved abandonment issues.
- Reason to avoid:
  - sounds cheap, intrusive, overconfident, and unsafe
  - breaks trust and reduces the product to either mysticism or diagnosis theater

## Follow-up Template Library
- The template library should provide reusable prompt shapes, not rigid scripts
- Templates should be selected by context, then lightly adapted to the current dream
- Each template should stay short, warm, and easy to answer

## Emotional Clarification Templates
- When the dream feeling is unclear:
  - If you keep just one feeling from this dream, which one feels closest?
  - When you woke up, did the feeling stay more like紧张、失落，还是说不清的不安？
  - If you had to name the feeling it left behind, what would be the nearest word?
- Use when:
  - dream scenes are vivid but emotional state is under-specified

## Focal Moment Templates
- When the dream has many scenes and needs one emotional anchor:
  - Which part of this dream stayed with you the longest?
  - If you only kept one image from this dream, which one would it be?
  - Was there a moment in it that felt especially heavy or clear?
- Use when:
  - interpretation quality depends on knowing the most charged moment

## Recurrence Confirmation Templates
- When the system suspects a repeat symbol or feeling and wants soft confirmation:
  - Does this feeling seem familiar from最近的一段时间，还是更像只属于这一次？
  - This image feels a little familiar. Does it remind you of a recent dream or state?
  - Has something like this been circling around lately, or does it feel new?
- Use when:
  - there is medium confidence for a repeat pattern and confirmation would genuinely help
- Use carefully:
  - never imply a pattern as settled before the user confirms or evidence is strong

## Relational Context Templates
- When a person or presence matters but the feeling of the relationship is unclear:
  - In the dream, did this person feel closer, farther away, or hard to place?
  - Was your feeling toward them more like熟悉、紧张，还是复杂得说不上来？
  - Did their presence feel comforting, unsettling, or something in between?
- Use when:
  - the dream revolves around a person and emotional meaning depends on the relationship tone

## Template Selection Rules
- Never ask more than needed just because templates exist
- Prefer one strong template over multiple weaker ones
- Adapt wording to the dream's emotional temperature:
  - calmer dream → softer phrasing
  - urgent dream → more direct but still gentle phrasing
- If the user already gave the answer implicitly, do not ask the question again

## Interpretation Template Library
- The interpretation library should define reusable response shapes, not rigid canned text
- Every result should feel tailored, but remain structurally consistent
- Recommended result sections:
  1. core insight
  2. symbolic layer
  3. personalized reflection
  4. gentle close

## Core Insight Templates
- Purpose:
  - immediately make the user feel the app understood the emotional center of the dream
- Template shapes:
  - This dream seems to hold a strong feeling of...
  - More than anything else, this dream feels close to...
  - At its center, this dream seems less about [surface event] and more about [inner feeling]
- Rules:
  - keep it short
  - lead with emotional truth, not explanation
  - avoid sounding dramatic or mystical

## Symbolic Layer Templates
- Purpose:
  - interpret the most meaningful elements without pretending symbolic certainty
- Template shapes:
  - [symbol/place] often carries the feeling of...
  - In dreams, [object/action] can sometimes point toward...
  - When [scene] appears, it can reflect a sense of...
- Rules:
  - explain only the most important 2-3 symbols
  - avoid encyclopedia-style symbol dumping
  - keep the meaning tied to the dream's felt atmosphere

## Personalized Reflection Templates
- Purpose:
  - connect the dream to the user's recent patterns only when evidence exists
- Template shapes:
  - This feels close to something that has been appearing in your recent dreams...
  - Compared with earlier dreams, this one feels more...
  - This may be touching a familiar theme around...
- Rules:
  - use only with enough evidence
  - reference change, contrast, or repetition carefully
  - if evidence is weak, stay with the present dream

## Gentle Close Templates
- Purpose:
  - leave the user with a sense of softness and reflection, not instruction or judgment
- Template shapes:
  - It may be enough just to notice...
  - You may not need to solve this right away; it could be worth staying with...
  - If this dream leaves anything with you, it may be the feeling of...
- Rules:
  - optional and short
  - no commands, no forced action, no self-help cliché

## Interpretation Anti-Patterns
- Avoid:
  - overlong output that feels like generic AI writing
  - too many symbols interpreted equally
  - absolute statements about what the dream means
  - diagnostic or pathological framing
  - supernatural certainty or fear language
- Bad examples:
  - This absolutely means...
  - Your subconscious is clearly telling you...
  - This proves you have...

## Template Use Principles
- The library should constrain tone and quality while allowing dream-specific variation
- The emotional center of the dream should determine output emphasis
- Current-dream clarity should always take priority over forcing continuity references
- The result should sound like one coherent voice, not four disconnected blocks

## Low-Fidelity Prototype Specs
- The first wireframe pass should focus on hierarchy, emotional pacing, and CTA placement rather than visual polish
- Each page should make one primary action obvious
- Secondary information should support continuity without overwhelming the screen

## Prototype Spec: Home
- Top area:
  - soft atmospheric header
  - one short invitation line
- Center area:
  - large primary CTA to start dream capture
  - optional subtle subtext reassuring low pressure
- Lower area:
  - one recent dream callback card
  - one recurring symbol / feeling strip
  - small links to archive and profile / patterns
- CTA priority:
  - primary: start telling dream
  - secondary: revisit archive

## Prototype Spec: Dream Capture
- Top area:
  - back / close affordance kept minimal
  - one short reassurance line
- Center area:
  - large recording control
  - breathing or wave feedback
  - elapsed time if needed, understated
- Lower area:
  - live transcription preview
  - end recording CTA becomes obvious only after useful input exists
- Interaction priority:
  - start speaking easily
  - avoid visual clutter that turns the moment technical

## Prototype Spec: Gentle Follow-up
- Top area:
  - short transition line indicating the app is reflecting on the dream
- Center area:
  - one question card only
  - compact answer options or short input
- Lower area:
  - skip action
  - continue action after answer
  - optional subtle progress indicator, but not quiz-like
- Interaction priority:
  - one calm step at a time
  - never feel like a survey form

## Prototype Spec: Interpretation Result
- Top area:
  - core insight block with strongest emotional resonance
- Middle area:
  - symbolic interpretation card(s)
  - personalized reflection card
- Lower area:
  - gentle close
  - save / archive CTA
  - login prompt only if it supports saving or continuity
- Interaction priority:
  - read, feel understood, then preserve

## Prototype Spec: Archive
- Top area:
  - simple title and soft context line
- Main list:
  - dream cards in timeline order
  - each card shows date, one short insight, key symbols / emotion markers
- Detail transition:
  - tapping opens full dream detail and interpretation
- Interaction priority:
  - scanning the past should feel calm and personal, not data-heavy

## Prototype Spec: Profile / Patterns
- Top area:
  - soft summary of the user's dream trajectory
- Middle area:
  - recurring symbols section
  - emotional themes section
  - repeated people / places section
- Lower area:
  - account / sync area
  - privacy / memory controls area
- Interaction priority:
  - make long-term growth visible without turning the page into a dashboard

## Page State Design
- Each major page should be designed as a small state system, not a single static screen
- State changes should feel emotionally smooth, not abrupt or technical
- Primary state transitions should reinforce trust, continuity, and calm pacing

## Home States
- New user state:
  - minimal page
  - one invitation line
  - one clear dream capture CTA
  - no heavy history or pattern modules
- Returning user state:
  - same core CTA
  - add one recent dream callback
  - add one subtle continuity cue
- Mature user state:
  - same core CTA remains dominant
  - slightly richer pattern surface allowed, but never enough to turn the page into a dashboard

## Dream Capture States
- Idle state:
  - recording has not started
  - reassure low-pressure speaking
- Recording state:
  - active motion feedback
  - live transcript appears quietly
  - user focus stays on recall, not correction
- Paused / review state:
  - transcript visible
  - option to continue or finish
- Ready-to-finish state:
  - clear CTA to continue into reflection / follow-up

## Follow-up States
- Single-choice state:
  - one soft question with compact tap options
- Short-text state:
  - one soft question with lightweight input
- Skip state:
  - user bypasses question without penalty
- Complete state:
  - graceful transition into result generation
- Important rule:
  - progress should feel like conversation unfolding, not steps in a form wizard

## Result States
- First-session result:
  - little or no continuity reference
  - save / login introduced only after value is felt
- Returning-user result:
  - continuity may appear if evidence supports it
  - archive and revisit actions become more meaningful
- Saved result state:
  - clear confirmation that the dream is now part of the user's archive
- Unsaved result state:
  - light continuity prompt, no pressure-heavy blocking

## Archive States
- Empty state:
  - warm invitation to record the first dream
- Populated state:
  - calm timeline view with easy scanning
- Dream detail state:
  - full interpretation + symbols + date context
- Important rule:
  - empty state should still feel beautiful and intentional, not unfinished

## Profile / Patterns States
- Early-use state:
  - limited pattern surface
  - explain that patterns will grow with use
- Emerging-pattern state:
  - a few recurring symbols or emotional themes appear
- Mature-pattern state:
  - stronger summaries and visible continuity over time
- Settings / privacy state:
  - account, sync, and memory controls remain accessible but visually secondary to the reflective content

## Component Inventory
- The UI should be assembled from reusable emotional-product components, not ad hoc one-off screens
- Components should support SwiftUI modularization and future design-system reuse

## Home Components
- atmospheric header
- invitation text block
- primary dream capture button
- reassurance subtext
- recent dream callback card
- recurring symbol / emotion strip
- archive entry link
- profile / patterns entry link

## Dream Capture Components
- minimal top bar
- reassurance line
- main recording orb / button
- motion feedback layer
- elapsed time label
- live transcript panel
- continue / finish action area

## Follow-up Components
- reflection transition text
- single question card
- compact answer chip group
- short text input field
- skip action
- continue action
- subtle progress indicator

## Interpretation Result Components
- core insight card
- symbolic interpretation card
- personalized reflection card
- gentle close block
- save to archive CTA block
- login continuity prompt block
- saved confirmation banner or inline state

## Archive Components
- archive header
- empty-state invitation block
- dream timeline list
- dream summary card
- dream detail header
- interpretation detail section
- symbol / emotion tag row

## Profile / Patterns Components
- trajectory summary block
- recurring symbols module
- emotional themes module
- repeated people / places module
- account / sync module
- privacy / memory controls module

## Component Principles
- Each component should communicate one clear idea
- Components should remain calm, spacious, and visually soft
- Reusable cards should support multiple states rather than requiring separate custom layouts
- The design system should privilege consistency of tone over decorative variety

## SwiftUI Component Trees
- These trees are implementation-oriented view hierarchies, not final code architecture
- Goal:
  - make it easy to move from product spec to screen/module planning
  - reveal reusable UI groupings early

## HomeView
- HomeView
  - AtmosphericHeaderView
  - InvitationTextView
  - PrimaryCaptureButton
  - ReassuranceSubtextView
  - RecentDreamCallbackCard
  - RecurringCueStrip
  - SecondaryNavigationRow
    - ArchiveEntryButton
    - ProfileEntryButton

## DreamCaptureView
- DreamCaptureView
  - MinimalTopBar
  - CaptureReassuranceText
  - RecordingOrbView
  - MotionFeedbackView
  - ElapsedTimeLabel
  - LiveTranscriptPanel
  - CaptureActionArea
    - PauseOrResumeButton
    - FinishCaptureButton

## FollowUpView
- FollowUpView
  - ReflectionTransitionText
  - FollowUpQuestionCard
    - QuestionPromptText
    - AnswerInputArea
      - AnswerChipGroup OR ShortTextField
  - FollowUpActionRow
    - SkipButton
    - ContinueButton
  - SubtleProgressView

## InterpretationResultView
- InterpretationResultView
  - CoreInsightCard
  - SymbolicInterpretationSection
    - SymbolInterpretationCard(s)
  - PersonalizedReflectionCard
  - GentleCloseBlock
  - ResultActionArea
    - SaveToArchiveButton
    - ArchiveLinkButton
  - OptionalContinuityPrompt
  - OptionalSavedConfirmationBanner

## ArchiveView
- ArchiveView
  - ArchiveHeaderView
  - ArchiveStateContainer
    - EmptyArchiveInvitationView OR DreamTimelineList
      - DreamSummaryCard
  - DreamDetailView
    - DreamDetailHeader
    - InterpretationDetailSection
    - SymbolEmotionTagRow

## ProfilePatternsView
- ProfilePatternsView
  - TrajectorySummaryBlock
  - RecurringSymbolsSection
  - EmotionalThemesSection
  - RepeatedPeoplePlacesSection
  - AccountSyncSection
  - PrivacyMemoryControlsSection

## Tree Design Principles
- Favor composition over monolithic page files
- Keep emotionally distinct blocks as separate components
- Reuse card patterns across Home, Result, Archive, and Profile where possible
- Let state drive composition instead of branching too much inside one giant view body

## Stitch Review Notes
- Current Stitch prototype direction is broadly aligned with the intended product tone:
  - premium
  - private
  - dreamy
  - emotionally soft
  - not overly SaaS-like
- The imported prototype confirms the brand direction is viable, but several screen-level adjustments are needed to preserve clarity and emotional focus.

## Review Notes: Home
- Strengths:
  - strong atmospheric entry
  - clear central visual anchor
  - continuity cue exists
- Issues to fix:
  - primary CTA still competes slightly with lower-page content
  - continuity card and pattern hints should stay lighter so the page does not drift toward dashboard behavior
  - tab bar should remain visually soft and secondary
- Design guidance:
  - make the main capture action feel even more singular
  - keep the page 80 percent emotional entry, 20 percent continuity support

## Review Notes: Dream Capture
- Strengths:
  - central orb works as the emotional anchor
  - layout is calm and spacious
  - recording action remains dominant
- Issues to fix:
  - the recording orb must avoid feeling too much like a generic AI voice assistant
  - live transcript area should feel like dream fragments, not chat text or utility transcription
  - finish action wording should stay soft and human
- Design guidance:
  - make the orb feel more like a dream core or emotional vessel than a system microphone
  - keep transcript presence subtle

## Review Notes: Gentle Follow-up
- Strengths:
  - single-question structure is correct
  - chip-based interaction is suitable
  - overall page avoids looking like a hard form
- Issues to fix:
  - answer chips risk feeling too standardized if the wording becomes label-like
  - progress indication must remain extremely subtle to avoid quiz energy
  - the page needs a little emotional transition language above the question so it feels like ongoing understanding
- Design guidance:
  - use feeling-language rather than taxonomy-language for answer options
  - make the interaction feel like a continuation of listening, not a survey step

## Current Visual Risks
- Home could become too content-heavy if continuity modules grow stronger
- Dream capture could drift toward AI assistant language if the orb or transcript become too technical
- Follow-up could drift toward questionnaire UX if chips, labels, or progress become too explicit

## Review Notes: Interpretation Result
- Strengths:
  - overall structure already supports a layered reading experience
  - the page visually feels calmer and more premium than a generic AI output screen
  - top-to-bottom hierarchy is present and the page can plausibly deliver emotional payoff
- Issues to fix:
  - the result content still risks reading as a stack of cards rather than one emotionally coherent journey
  - the top core insight area needs to feel even more singular and emotionally resonant
  - symbolic and personalized sections should be visually distinct, but not so separated that the page feels fragmented
  - the save CTA must feel like preserving continuity, not a standard product action button
- Design guidance:
  - strengthen the first-screen emotional anchor so the user feels understood before reading details
  - keep the symbolic section compact and avoid visual density that suggests encyclopedic analysis
  - make the personalized reflection section warmer and slightly more intimate than the symbolic layer
  - treat the lower save area as a soft continuation prompt, not a conversion block

## Result Page Risks
- If too many cards have equal visual weight, the page will feel like generated content modules rather than a crafted interpretation
- If the save action looks too transactional, the emotional afterglow of the page will weaken
- If the symbolic layer is too long or too detailed, the result may drift toward generic AI analysis instead of meaningful insight

## Review Notes: Patterns
- Strengths:
  - the page clearly attempts to visualize long-term inner patterns rather than just list old dreams
  - it has stronger product-differentiation potential than a standard history view
  - the direction supports the "the app is gradually understanding me" promise
- Issues to fix:
  - the page risks becoming too data-dashboard-like if the trajectory visualization and pattern modules carry too much analytical weight
  - pattern blocks need to feel interpreted and reflective, not merely counted or measured
  - the top trajectory area should feel like a poetic summary of change over time, not an analytics chart
  - recurring symbols, themes, and people/places should not all compete equally for attention
- Design guidance:
  - reduce the feeling of metrics and increase the feeling of narrative continuity
  - use one dominant trajectory summary, then 2-3 secondary reflective modules
  - keep labels human and emotionally readable rather than abstract taxonomy
  - make the page feel like slow self-recognition, not quantified-self visualization

## Patterns Page Risks
- If the chart or waveform is too literal, the page may drift into mood-tracker or analytics-tool territory
- If counts and pattern chips dominate, the page may lose emotional meaning and become decorative statistics
- If all modules are equally loud, the long-term insight will feel fragmented instead of deepening

## Conversation-Derived Decisions
1. Build for iOS first.
2. Start with the “growth version,” not a minimal toy MVP and not a full commercial system.
3. Use a hybrid positioning: dream interpretation on the surface, emotional companionship underneath.
4. Use dual-engine personalization: dream memory + emotional / psychological state modeling.
5. Input should be voice-first with soft, structured follow-up.
6. Follow-up should not feel stiff or unfriendly.
7. The main product loop should be: capture → gentle context gathering → interpretation.
8. The output should combine symbolic interpretation with personalized emotional insight.
9. Use a hybrid data strategy: raw dream content local-first, AI interpretation and memory summarization cloud-assisted.
10. Ship a more complete v1 with login, cloud sync, and richer profile presentation.
11. Let users experience the product before requiring login.
12. Use a light-luxury spiritual visual direction.
13. Design the user journey as entry into a private dream space, with value before commitment.
14. Keep the home experience minimal, emotionally inviting, and centered on one action.
15. Make the capture and follow-up flow feel conversational, warm, and low-pressure.
16. Design the result and archive experience around layered insight and long-term continuity.
17. Use a gentle, restrained, reflective content style across the product.
18. Structure v1 around Home, Dream Flow, Archive, and Profile / Patterns.
19. Keep each page focused on one clear job with strict v1 feature discipline.
20. Design three core flows: first-time use, returning use, and post-result save/login.
21. Tie conversion and retention to preserved continuity and accurate memory, not interruption.
22. Protect the product from low-trust mysticism, fake personalization, overbuilt scope, and weak privacy signals.
23. Use structured AI outputs with careful personalization and confidence-aware memory updates.
24. Design memory as two linked layers: dream memory and emotional profile memory.
25. Let memory visibility and strength grow gradually, with user-readable controls and explanations.
26. Design follow-up as a minimal, gentle clarification system with strong rules for when not to ask.
27. Validate product quality with realistic sample dream flows and anti-pattern examples.
28. Use a reusable follow-up template library selected by context and adapted lightly per dream.
29. Use a structured interpretation template library to keep result quality elevated and consistent.
30. Create low-fidelity prototype specs centered on hierarchy, emotional pacing, and CTA clarity.
31. Treat each major screen as a state system with smooth emotional transitions.
32. Organize the UI as a reusable component inventory suitable for SwiftUI modularization.
33. Map each major screen to a SwiftUI-friendly component tree for implementation planning.
34. First-round Stitch review confirms the visual direction is viable, with focused adjustments needed for home, capture, and follow-up clarity.
35. Interpretation result design should feel more like one crafted emotional arc and less like equal-weight analysis cards.
36. Patterns design should emphasize narrative continuity over dashboard-style pattern metrics.
37. Safe Harbor should feel like an emotional refuge and self-regulation space, not a feature feed or content library.
38. Private Whispers should feel like intimate, high-trust personal guidance, not push notifications, generic affirmations, or chat messages.

## Review Notes: Safe Harbor
- Strengths:
  - the page already introduces a distinct emotional role beyond dream capture and interpretation
  - the softer card structure supports the idea of a protected, restorative space
  - the visual tone is consistent with the premium, private, dreamlike direction
- Issues to fix:
  - the page risks feeling like a generic wellness-content hub if the modules read as equal-weight content tiles
  - the top area needs a clearer emotional promise so users immediately understand why this space exists
  - if there are too many entry points or content categories, the page may lose intimacy and become feature inventory
  - support actions should feel grounding and personal, not like browsing resources in an app marketplace
- Design guidance:
  - position the page as a refuge for difficult nights, emotional overflow, or moments when the user does not want full interpretation
  - use one dominant calming anchor at the top, followed by a very small number of secondary supportive paths
  - make copy feel soothing, protective, and human rather than instructional or therapeutic-systematic
  - preserve visual quiet and avoid dense grids, loud labels, or overly explicit utility framing

## Safe Harbor Page Risks
- If the page becomes too content-heavy, it will feel like a wellness dashboard instead of a private refuge
- If all support modules have similar hierarchy, the user will not know where emotional safety begins
- If the tone becomes too clinical, therapeutic, or self-help generic, it will weaken the brand’s intimate dream-world identity

## Review Notes: Private Whispers
- Strengths:
  - the page has strong potential to deepen the app’s sense of intimacy and long-term personal understanding
  - the quieter layout direction supports a one-to-one emotional tone rather than a broad social or content feel
  - it can become an important differentiator if it feels like rare, meaningful guidance instead of routine app output
- Issues to fix:
  - the page risks feeling like a generic affirmation feed or AI-chat variation if the message blocks become too frequent, too similar, or too obviously system-generated
  - hierarchy needs to make one whisper feel precious and intentional rather than one item in a scrolling list
  - if decorative styling dominates without enough emotional specificity, the page may feel vague rather than deeply personal
  - any response or follow-up action should stay soft and optional so the page does not become a disguised conversation workflow
- Design guidance:
  - treat each whisper as a carefully surfaced moment of reflection derived from dream history and emotional continuity
  - prioritize one primary intimate message, with only minimal surrounding context about why it is appearing now
  - make the writing feel warm, perceptive, and private without sounding mystical-forced, therapeutic-scripted, or chatbot-like
  - keep interaction lightweight so the emotional value is in receiving and recognizing, not in managing another feed

## Private Whispers Page Risks
- If it becomes a stack of cards or daily messages, it will lose rarity and emotional weight
- If it sounds too generic, users will read it as AI filler rather than earned personal insight
- If it behaves too much like chat, coaching, or notifications, it will weaken the product’s quiet-luxury and dream-ritual identity

## Cross-Screen Architecture Synthesis
- The current 7-screen system is directionally strong, but it should be understood as three different product layers rather than one flat navigation set.
- Layer 1: Core ritual flow
  - Home
  - Dream Capture
  - Gentle Follow-up
  - Interpretation Result
- Layer 2: Continuity and understanding
  - Patterns
  - Archive / saved interpretations
- Layer 3: Emotional support extensions
  - Safe Harbor
  - Private Whispers
- This matters because the prototype currently risks letting secondary spaces compete visually and conceptually with the core ritual.

## Page Role Map
- Home:
  - invitation and re-entry point
  - should primarily launch the dream ritual, not summarize the whole product
- Dream Capture:
  - emotional recording threshold
  - should feel like entering the dream itself
- Gentle Follow-up:
  - minimal clarification bridge
  - should feel like listening continuing, not questioning beginning
- Interpretation Result:
  - emotional payoff and meaning-making surface
  - should be the most crafted and high-value content moment in the product
- Patterns:
  - slow recognition of long-term themes
  - should express continuity, not analytics
- Safe Harbor:
  - refuge state for vulnerable or overloaded moments
  - should support emotional regulation without asking for performance
- Private Whispers:
  - rare intimate resurfacing of earned insight
  - should feel precious, sparse, and highly personal

## Navigation Relationship Guidance
- The app should not present all destinations as equal emotional weight.
- Recommended hierarchy:
  - Primary path:
    - Home → Capture → Follow-up → Result
  - Secondary continuity path:
    - Home ↔ Patterns
    - Result → Save / Archive / Patterns light continuity prompts
  - Tertiary support path:
    - Home or Result → Safe Harbor
    - Home or Patterns → Private Whispers
- Archive should likely remain structurally present but visually quieter than Patterns in the prototype, because archive is storage while patterns is meaning.
- Safe Harbor and Private Whispers should feel discovered or gently offered, not promoted as main app tasks.

## Cross-Screen Priority Adjustments
- Increase priority:
  - Interpretation Result as the emotional center of the whole product
  - Patterns as the primary long-term differentiation layer
- Keep strong but restrained:
  - Home continuity modules
  - Archive visibility
- Reduce risk of overexposure:
  - Safe Harbor should not expand into a content ecosystem in v1
  - Private Whispers should not become a high-frequency feed in v1
- The product should feel like one ritual with two supporting memory layers, not seven parallel features.

## Information Architecture Recommendations
- Bottom-level navigation, if retained, should emphasize only the highest-level stable destinations.
- Recommended stable navigation set for v1:
  - Home
  - Patterns
  - Archive
  - Profile / Me
- Dream Capture, Gentle Follow-up, and Interpretation Result should behave as flow states, not persistent nav destinations.
- Safe Harbor and Private Whispers should be treated as contextual destinations:
  - entered from moments of need
  - surfaced from result/history/pattern cues
  - not forced into constant top-level prominence

## Product Coherence Rules
- Each page must answer a different emotional need:
  - Home = invitation
  - Capture = expression
  - Follow-up = clarification
  - Result = understanding
  - Patterns = continuity
  - Safe Harbor = soothing
  - Private Whispers = intimacy
- No page should duplicate another page’s job with different styling.
- Long-term trust depends on scarcity and precision:
  - Patterns should not become metrics
  - Safe Harbor should not become content browsing
  - Private Whispers should not become generic daily advice
- The strongest version of the app feels less like a feature suite and more like a private dream companion with depth over time.

## Prototype-Level Next Adjustments
- Home:
  - simplify secondary modules further
- Result:
  - strengthen top emotional anchor and crafted narrative arc
- Patterns:
  - make it the clearest long-term-memory surface
- Safe Harbor:
  - reduce feature-grid feeling and clarify refuge promise
- Private Whispers:
  - increase rarity, singularity, and emotional specificity

## Final v1 Page Structure
- Persistent destinations:
  - Home
  - Patterns
  - Archive
  - Profile / Me
- Flow-only states:
  - Dream Capture
  - Gentle Follow-up
  - Interpretation Result
- Contextual destinations:
  - Safe Harbor
  - Private Whispers
- This structure preserves a calm top-level app shape while keeping the emotionally important ritual flow immersive.

## v1 Page Priority Table
| Page | v1 Priority | Role | Navigation Status | Main Constraint |
| --- | --- | --- | --- | --- |
| Home | P0 | entry and re-entry ritual doorway | persistent | must stay singular and not become dashboard-heavy |
| Dream Capture | P0 | dream expression state | flow-only | must not feel like generic voice assistant UX |
| Gentle Follow-up | P0 | minimal clarification bridge | flow-only | must not feel like a questionnaire |
| Interpretation Result | P0 | emotional payoff and meaning surface | flow-only | must feel crafted, not card-stacked AI output |
| Patterns | P1-high | long-term continuity and differentiation | persistent | must not feel like analytics |
| Archive | P1 | saved dream memory access | persistent | must remain quieter than patterns |
| Profile / Me | P1 | account, sync, memory controls | persistent | should support trust, not dominate the experience |
| Safe Harbor | P2-contextual | emotional refuge / recovery | contextual | must not become a wellness content hub |
| Private Whispers | P2-contextual | rare intimate resurfaced guidance | contextual | must not become a feed, chat, or affirmation stream |

## Recommended v1 Navigation Model
- Bottom navigation:
  - Home
  - Patterns
  - Archive
  - Me
- Primary CTA behavior:
  - the strongest action from Home should immediately open Dream Capture
- Flow progression:
  - Capture → Gentle Follow-up → Interpretation Result
- Post-result exits:
  - Save to Archive
  - Return Home
  - Light link into Patterns when continuity is relevant
- Contextual support entry points:
  - Safe Harbor can appear from Home, Result, or emotionally heavy moments
  - Private Whispers can surface from Home, Patterns, or special continuity moments

## Page Inclusion Logic for v1
- Must feel fully realized in v1:
  - Home
  - Capture
  - Follow-up
  - Result
  - Patterns
- Must exist, but can stay visually restrained in v1:
  - Archive
  - Profile / Me
- Should exist only if implemented with strong restraint:
  - Safe Harbor
  - Private Whispers
- If Safe Harbor or Private Whispers cannot reach the right emotional specificity in v1, they should ship in a lighter form rather than expanded form.

## Prototype Reduction Guidance
- If the prototype still feels busy, reduce in this order:
  1. shrink secondary modules on Home
  2. reduce visible options inside Safe Harbor
  3. reduce the number of whisper surfaces in Private Whispers
  4. compress archive preview presence on top-level surfaces
- Do not reduce:
  - the emotional clarity of Result
  - the singularity of Capture
  - the narrative value of Patterns

## Implementation Planning Implication
- The implementation should be planned around 4 stable shells plus 1 ritual flow system.
- Stable shells:
  - Home
  - Patterns
  - Archive
  - Profile / Me
- Ritual flow system:
  - Capture
  - Follow-up
  - Result
- Contextual modules:
  - Safe Harbor
  - Private Whispers
- This should make the later SwiftUI architecture cleaner because navigation and emotional hierarchy will match.

## Open Questions
- Should the first release support anonymous local-only use, account-based sync, or both?
- Should AI memory live fully on-device, in the cloud, or as a hybrid architecture?
- What should the visual tone be: mystical, calm premium, feminine healing, or minimal modern?
- What business model should the first public version use?

## Working Agreement
This file is a living project document. It should be updated as our conversation refines the product.
