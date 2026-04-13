import Foundation

protocol PrivateWhisperServicing {
    func loadWhispers() -> [PrivateWhisper]
}

struct PrivateWhisperService: PrivateWhisperServicing {
    func loadWhispers() -> [PrivateWhisper] {
        [
            PrivateWhisper(
                featuredText: "A quieter pattern may be asking for your attention, not your urgency."
            )
        ]
    }
}
