import Foundation

protocol PatternSummaryServicing {
    func loadSummary() -> PatternSummary
}

struct PatternSummaryService: PatternSummaryServicing {
    enum Scenario {
        case early
        case established
    }

    private let scenario: Scenario

    init(scenario: Scenario = .established) {
        self.scenario = scenario
    }

    func loadSummary() -> PatternSummary {
        switch scenario {
        case .early:
            .earlyUse
        case .established:
            .establishedUse
        }
    }
}
