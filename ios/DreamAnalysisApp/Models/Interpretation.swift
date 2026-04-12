import Foundation

struct Interpretation: Equatable, Sendable {
    var summary: String

    init(summary: String = "") {
        self.summary = summary
    }
}
