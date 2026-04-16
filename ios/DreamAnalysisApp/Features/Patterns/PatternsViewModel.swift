import Observation

@Observable
final class PatternsViewModel {
    struct PeoplePlacesRow: Equatable {
        let title: String
        let items: [String]
    }

    let patternSummary: PatternSummary

    init(patternSummary: PatternSummary) {
        self.patternSummary = patternSummary
    }

    var shouldExplainGrowth: Bool {
        patternSummary.stage == .early
    }

    var trajectoryTitle: String {
        "How your dream story is moving"
    }

    var recurringSymbols: [PatternSummary.RecurringSymbol] {
        patternSummary.recurringSymbols
    }

    var peoplePlacesRows: [PeoplePlacesRow] {
        [
            PeoplePlacesRow(title: "Recurring people", items: patternSummary.recurringPeople),
            PeoplePlacesRow(title: "Recurring places", items: patternSummary.recurringPlaces)
        ]
        .filter { !$0.items.isEmpty }
    }

    var emotionalTrendSummary: String? {
        patternSummary.emotionalTrendSummary?.trimmingToNil
    }

    var profileReflection: String? {
        patternSummary.profileReflection?.trimmingToNil
    }

    var recentThemeSummary: String? {
        patternSummary.recentThemeSummary?.trimmingToNil
    }
}

private extension String {
    var trimmingToNil: String? {
        let value = trimmingCharacters(in: .whitespacesAndNewlines)
        return value.isEmpty ? nil : value
    }
}
