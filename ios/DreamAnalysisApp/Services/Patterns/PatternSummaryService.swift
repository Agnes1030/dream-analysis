import Foundation

protocol PatternSummaryServicing {
    func loadSummary() -> PatternSummary
}

struct PatternSummaryService: PatternSummaryServicing {
    func loadSummary() -> PatternSummary {
        .earlyUse
    }
}
