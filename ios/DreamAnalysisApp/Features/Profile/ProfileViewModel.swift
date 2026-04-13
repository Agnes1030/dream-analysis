import Observation

@Observable
final class ProfileViewModel {
    let showsMemoryControls = true
    let syncExplanation = "Your dream history can stay quietly in step across devices when you choose to keep it."
    let privacyExplanation = "Raw dream details can remain close to you, while only the context needed for interpretation is shared."
    let memoryExplanation = "Memory helps the app notice returning symbols, feelings, and places so each reflection can feel more familiar over time."

    var explanationStrings: [String] {
        [syncExplanation, privacyExplanation, memoryExplanation]
    }
}
