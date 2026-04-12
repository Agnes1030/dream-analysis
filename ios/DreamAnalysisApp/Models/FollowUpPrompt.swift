import Foundation

struct FollowUpPrompt: Equatable, Sendable {
    var id: String
    var prompt: String

    init(id: String = UUID().uuidString, prompt: String = "") {
        self.id = id
        self.prompt = prompt
    }
}
