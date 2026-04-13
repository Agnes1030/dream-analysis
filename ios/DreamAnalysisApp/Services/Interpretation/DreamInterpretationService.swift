import Foundation

protocol DreamInterpretationServicing {
    func interpret(dream: DreamEntry) -> Interpretation
}

struct DreamInterpretationService: DreamInterpretationServicing {
    func interpret(dream: DreamEntry) -> Interpretation {
        let transcript = dream.rawTranscript.trimmingCharacters(in: .whitespacesAndNewlines)
        let normalizedTranscript = transcript.isEmpty ? "this dream" : transcript
        let transcriptLength = transcript.count

        return Interpretation(
            coreInsight: "This first reflection stays close to what you shared: \(normalizedTranscript).",
            symbolicSummary: "Placeholder reading based on the dream transcript alone: \(transcriptLength) characters were captured for this entry.",
            personalReflection: "Begin by noticing which part of \"\(normalizedTranscript)\" still feels most emotionally charged after waking."
        )
    }
}
