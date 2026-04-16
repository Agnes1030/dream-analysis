import Observation

@Observable
final class ProfileViewModel {
    enum MemorySectionRow: Equatable {
        case control(title: String, detail: String, isEnabled: Bool)
        case infoCard(title: String, detail: String)
        case explanation(title: String, detail: String)
    }

    let showsMemoryControls = true
    let patternSummary: PatternSummary

    var usePriorPatternsInInterpretation = true
    var surfaceContinuityCuesOnReturn = true

    let priorPatternsExplanation = "Use prior patterns in later interpretations when it helps add continuity."
    let continuityCuesExplanation = "Surface gentle continuity cues when you return, like familiar symbols or emotional threads."
    let memoryExplanation = "Right now this app uses a local pattern summary drawn from your recurring symbols and trajectory, not full account sync."
    let syncInfrastructureExplanation = "Account and sync can grow into continuity infrastructure later. In this version, your controls stay on this device and your memory summary stays intentionally small."
    let privacyExplanation = "Raw dream details do not need to travel far for this page to be useful. What appears here is a compact continuity summary, not a complete replay of everything you shared."

    init(patternSummary: PatternSummary = .earlyUse) {
        self.patternSummary = patternSummary
    }

    var memorySectionRows: [MemorySectionRow] {
        [
            .control(
                title: "Use prior patterns",
                detail: priorPatternsExplanation,
                isEnabled: usePriorPatternsInInterpretation
            ),
            .control(
                title: "Surface continuity cues",
                detail: continuityCuesExplanation,
                isEnabled: surfaceContinuityCuesOnReturn
            ),
            .infoCard(
                title: noticingSectionTitle,
                detail: noticingSummary
            ),
            .infoCard(
                title: "What memory is in use right now",
                detail: memoryExplanation
            ),
            .explanation(
                title: "Privacy",
                detail: privacyExplanation
            ),
            .explanation(
                title: "Account and sync",
                detail: syncInfrastructureExplanation
            )
        ]
    }

    var explanationStrings: [String] {
        memorySectionRows.compactMap { row in
            switch row {
            case let .control(_, detail, _), let .infoCard(_, detail), let .explanation(_, detail):
                detail
            }
        }
    }

    var noticingSectionTitle: String {
        "What the app is noticing"
    }

    var noticingSummary: String {
        let namedSymbols = patternSummary.recurringSymbols.map(\.name)

        if namedSymbols.isEmpty {
            return "It is currently holding one early continuity note: \(patternSummary.trajectorySummary)"
        }

        if namedSymbols.count == 1 {
            return "It is currently noticing \(namedSymbols[0]), along with a broader shift: \(patternSummary.trajectorySummary)"
        }

        let finalName = namedSymbols[namedSymbols.count - 1]
        let leadingNames = namedSymbols.dropLast().joined(separator: ", ")
        return "It is currently noticing \(leadingNames) and \(finalName), along with a broader shift: \(patternSummary.trajectorySummary)"
    }
}
