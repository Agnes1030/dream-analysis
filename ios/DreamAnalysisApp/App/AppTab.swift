import Foundation

enum AppTab: Hashable, CaseIterable {
    case home
    case patterns
    case archive
    case me

    var title: String {
        switch self {
        case .home:
            "Home"
        case .patterns:
            "Patterns"
        case .archive:
            "Archive"
        case .me:
            "Me"
        }
    }

    var systemImageName: String {
        switch self {
        case .home:
            "moon.stars"
        case .patterns:
            "sparkles.rectangle.stack"
        case .archive:
            "tray.full"
        case .me:
            "person"
        }
    }
}
