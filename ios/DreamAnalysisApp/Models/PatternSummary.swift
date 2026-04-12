import Foundation

struct PatternSummary: Equatable, Sendable {
    var title: String
    var detail: String

    init(title: String = "", detail: String = "") {
        self.title = title
        self.detail = detail
    }
}
