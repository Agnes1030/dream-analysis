import Foundation

struct Interpretation: Equatable, Sendable {
    var coreInsight: String
    var symbolicSummary: String
    var personalReflection: String

    init(
        coreInsight: String = "",
        symbolicSummary: String = "",
        personalReflection: String = ""
    ) {
        self.coreInsight = coreInsight
        self.symbolicSummary = symbolicSummary
        self.personalReflection = personalReflection
    }
}
