import Foundation

struct PrivateWhisper: Equatable, Sendable {
    var text: String

    init(text: String = "") {
        self.text = text
    }
}
