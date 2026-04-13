import Observation

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
}
