import Foundation

struct PreviewFixtures {
    let dream = DreamEntry(rawTranscript: "I was walking through a blue garden at night.")
    let followUpPrompt = FollowUpPrompt(
        id: "feeling",
        prompt: "If it fits, what feeling stayed with you most?",
        inputStyle: .chips,
        options: ["Uneasy", "Calm", "Curious"]
    )
    let interpretation = Interpretation(
        coreInsight: "Part of you may be looking for calm without losing closeness.",
        symbolicSummary: "Night colors, a garden, and wandering imagery can suggest inward tending, privacy, and emotional renewal.",
        personalReflection: "This dream may be reflecting a wish to move more gently with feelings that have been hard to name in the daytime."
    )

    static let demo = PreviewFixtures()
}
