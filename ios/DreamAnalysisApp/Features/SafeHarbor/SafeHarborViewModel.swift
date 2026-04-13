import Observation

@Observable
final class SafeHarborViewModel {
    let items: [SafeHarborItem]

    init(items: [SafeHarborItem] = SafeHarborService().loadItems()) {
        self.items = items
    }

    var primaryItem: SafeHarborItem? {
        items.first
    }

    var secondaryItems: [SafeHarborItem] {
        Array(items.dropFirst())
    }
}
