import Foundation

enum FollowUpInputStyle: String, Equatable, Sendable {
    case chips
    case text
}

struct FollowUpPrompt: Equatable, Sendable {
    var id: String
    var prompt: String
    var inputStyle: FollowUpInputStyle
    var options: [String]

    init(
        id: String = UUID().uuidString,
        prompt: String = "",
        inputStyle: FollowUpInputStyle = .text,
        options: [String] = []
    ) {
        self.id = id
        self.prompt = prompt
        self.inputStyle = inputStyle
        self.options = options
    }
}
