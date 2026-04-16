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
    let patternSummary = PatternSummary(
        title: "A steadier thread is already visible",
        detail: "Preview data should flow through fixtures so the sample summary stays in one place.",
        stage: .established,
        trajectorySummary: "Recent dreams suggest a movement from bracing for uncertainty toward recognizing what can hold you through it.",
        recurringSymbols: [
            .init(
                id: "lantern",
                name: "Lantern",
                note: "Lanterns return when the dream is searching for enough light to continue, not full clarity."
            ),
            .init(
                id: "shoreline",
                name: "Shoreline",
                note: "Edges of water appear when emotion is close but still being approached carefully."
            )
        ],
        recurringPeople: ["An old friend"],
        recurringPlaces: ["A quiet station"],
        emotionalTrendSummary: "The feeling tone is becoming less urgent and more companionable.",
        profileReflection: "Your dreams keep practicing how to stay near transition without disappearing inside it.",
        recentThemeSummary: "Lately the themes of return, orientation, and trust seem to be surfacing together."
    )

    static let demo = PreviewFixtures()
}
