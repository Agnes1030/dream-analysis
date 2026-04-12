import Observation

@Observable
final class FollowUpViewModel {
    let prompt: FollowUpPrompt
    var answer: String?
    var isComplete = false

    init(prompt: FollowUpPrompt) {
        self.prompt = prompt
    }

    func selectOption(_ option: String) {
        answer = option
        isComplete = true
    }

    func submitTextAnswer(_ text: String) {
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmedText.isEmpty == false else {
            answer = nil
            return
        }

        answer = trimmedText
        isComplete = true
    }

    func skip() {
        answer = nil
        isComplete = true
    }
}
