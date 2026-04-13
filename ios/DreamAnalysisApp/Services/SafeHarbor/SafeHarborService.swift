import Foundation

protocol SafeHarborServicing {
    func loadItems() -> [SafeHarborItem]
}

struct SafeHarborService: SafeHarborServicing {
    func loadItems() -> [SafeHarborItem] {
        [.breathing, .warmLight]
    }
}
