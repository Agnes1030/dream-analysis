import Foundation

struct SafeHarborItem: Equatable, Sendable {
    var title: String
    var detail: String

    init(title: String = "", detail: String = "") {
        self.title = title
        self.detail = detail
    }
}

extension SafeHarborItem {
    static let breathing = SafeHarborItem(
        title: "Return to your breathing",
        detail: "Let one slower inhale and exhale remind your body that this moment can stay gentle."
    )

    static let warmLight = SafeHarborItem(
        title: "Picture one steady light",
        detail: "Imagine a quiet light nearby, staying with you until the dream feeling softens."
    )
}
