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

    init(
        title: String = "",
        detail: String = "",
        stage: Stage = .early,
        trajectorySummary: String = "",
        recurringSymbols: [RecurringSymbol] = []
    ) {
        self.title = title
        self.detail = detail
        self.stage = stage
        self.trajectorySummary = trajectorySummary
        self.recurringSymbols = recurringSymbols
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
}
