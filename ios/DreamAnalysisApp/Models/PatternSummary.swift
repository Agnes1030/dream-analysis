import Foundation

struct PatternSummary: Equatable, Sendable {
    enum Stage: Equatable, Sendable {
        case early
        case established
    }

    struct RecurringSymbol: Equatable, Sendable, Identifiable {
        let id: String
        var name: String
        var note: String

        init(id: String, name: String, note: String) {
            self.id = id
            self.name = name
            self.note = note
        }
    }

    var title: String
    var detail: String
    var stage: Stage
    var trajectorySummary: String
    var recurringSymbols: [RecurringSymbol]
    var recurringPeople: [String]
    var recurringPlaces: [String]
    var emotionalTrendSummary: String?
    var profileReflection: String?
    var recentThemeSummary: String?

    init(
        title: String = "",
        detail: String = "",
        stage: Stage = .early,
        trajectorySummary: String = "",
        recurringSymbols: [RecurringSymbol] = [],
        recurringPeople: [String] = [],
        recurringPlaces: [String] = [],
        emotionalTrendSummary: String? = nil,
        profileReflection: String? = nil,
        recentThemeSummary: String? = nil
    ) {
        self.title = title
        self.detail = detail
        self.stage = stage
        self.trajectorySummary = trajectorySummary
        self.recurringSymbols = recurringSymbols
        self.recurringPeople = recurringPeople
        self.recurringPlaces = recurringPlaces
        self.emotionalTrendSummary = emotionalTrendSummary
        self.profileReflection = profileReflection
        self.recentThemeSummary = recentThemeSummary
    }
}

extension PatternSummary {
    static let earlyUse = PatternSummary(
        title: "Your dream language is still taking shape",
        detail: "A few images are beginning to repeat, and their meaning can grow clearer with time.",
        stage: .early,
        trajectorySummary: "Right now, the value is in noticing continuity from one dream to the next instead of trying to force a hard conclusion.",
        recurringSymbols: [
            RecurringSymbol(
                id: "water",
                name: "Water",
                note: "It has shown up enough to feel familiar, but not enough to claim a fixed meaning yet."
            )
        ]
    )

    static let establishedUse = PatternSummary(
        title: "A more continuous dream story is starting to appear",
        detail: "Certain images, settings, and emotional movements now feel connected across multiple dreams.",
        stage: .established,
        trajectorySummary: "Across recent dreams, the movement seems to be from searching in uncertain spaces toward recognizing what asks for care.",
        recurringSymbols: [
            RecurringSymbol(
                id: "water",
                name: "Water",
                note: "Water keeps appearing at moments when emotion feels close to the surface but not fully expressed."
            ),
            RecurringSymbol(
                id: "stairs",
                name: "Stairs",
                note: "Stairs often arrive in transition points, especially when the dream is moving between hesitation and approach."
            )
        ],
        recurringPeople: ["Your sister", "A quiet guide"],
        recurringPlaces: ["Childhood home", "Train platforms"],
        emotionalTrendSummary: "The emotional tone is shifting from urgency toward steadier forms of concern and care.",
        profileReflection: "Your dreams often return to moments of transition, but they are becoming less about being lost inside them and more about staying present while they unfold.",
        recentThemeSummary: "Recently, your dreams seem to be circling questions of return, responsibility, and how to move without abandoning yourself."
    )
}
