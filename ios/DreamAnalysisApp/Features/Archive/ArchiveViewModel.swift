import Foundation
import Observation

struct ArchiveContinuitySummary: Equatable {
    let title: String
    let motifSnapshot: String
    let emotionalDirection: String
    let framing: String
}

@Observable
final class ArchiveViewModel {
    var dreams: [DreamEntry]
    var selectedDream: DreamEntry?

    init(dreams: [DreamEntry], selectedDream: DreamEntry? = nil) {
        self.dreams = []
        self.selectedDream = selectedDream
        updateDreams(dreams)
    }

    var showsEmptyState: Bool {
        dreams.isEmpty
    }

    var emptyStateTitle: String {
        "Archive"
    }

    var emptyStateMessage: String {
        "Saved dreams can rest here for a later return."
    }

    var continuitySummary: ArchiveContinuitySummary? {
        guard !dreams.isEmpty else {
            return nil
        }

        return ArchiveContinuitySummary(
            title: "A living history",
            motifSnapshot: motifSnapshot,
            emotionalDirection: emotionalDirection,
            framing: "These dreams begin to trace a quieter thread over time, holding what seems to return."
        )
    }

    func updateDreams(_ dreams: [DreamEntry]) {
        self.dreams = dreams.sorted { $0.createdAt > $1.createdAt }

        guard let selectedDream else {
            return
        }

        self.selectedDream = self.dreams.first { $0.id == selectedDream.id }
    }

    func selectDream(_ dream: DreamEntry) {
        selectedDream = dream
    }

    private var motifSnapshot: String {
        let recurringMotifs = recurringValues(from: dreams.flatMap(\.tags))

        guard !recurringMotifs.isEmpty else {
            return "Recurring motifs: gentle fragments still gathering"
        }

        return "Recurring motifs: \(recurringMotifs.joined(separator: ", "))"
    }

    private var emotionalDirection: String {
        let recentEmotions = uniqueOrderedValues(from: Array(dreams.prefix(3)).flatMap(\.emotionalMarkers)).prefix(2)

        guard !recentEmotions.isEmpty else {
            return "Recent emotional direction: still unfolding"
        }

        return "Recent emotional direction: \(recentEmotions.joined(separator: ", "))"
    }

    private func recurringValues(from values: [String]) -> [String] {
        var counts: [String: Int] = [:]
        var canonicalValues: [String: String] = [:]
        var firstSeenOrder: [String] = []

        for value in values {
            let normalized = normalize(value)
            let canonical = canonicalMotif(for: normalized)

            guard !canonical.isEmpty else {
                continue
            }

            if counts[canonical] == nil {
                firstSeenOrder.append(canonical)
                canonicalValues[canonical] = canonical
            }
            counts[canonical, default: 0] += 1
        }

        return firstSeenOrder.compactMap { canonical in
            guard counts[canonical, default: 0] > 1 else {
                return nil
            }

            return canonicalValues[canonical]
        }
    }

    private func uniqueOrderedValues(from values: [String]) -> [String] {
        var seen: Set<String> = []
        var ordered: [String] = []

        for value in values.map(normalize).filter({ !$0.isEmpty }) {
            guard !seen.contains(value) else {
                continue
            }

            seen.insert(value)
            ordered.append(value)
        }

        return ordered
    }

    private func normalize(_ value: String) -> String {
        value.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }

    private func canonicalMotif(for value: String) -> String {
        switch value {
        case "home":
            return "house"
        default:
            return value
        }
    }
}
