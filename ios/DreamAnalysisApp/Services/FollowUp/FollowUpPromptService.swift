import Foundation

protocol FollowUpPromptServicing {
    func prompts(for dream: DreamEntry) -> [FollowUpPrompt]
}

struct FollowUpPromptService: FollowUpPromptServicing {
    func prompts(for dream: DreamEntry) -> [FollowUpPrompt] {
        [
            FollowUpPrompt(
                id: "feeling",
                prompt: "If it fits, what feeling stayed with you most?",
                inputStyle: .chips,
                options: ["Uneasy", "Calm", "Curious", "Heavy"]
            )
        ]
    }
}
