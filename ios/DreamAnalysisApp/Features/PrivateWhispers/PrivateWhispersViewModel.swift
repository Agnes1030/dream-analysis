import Observation

@Observable
final class PrivateWhispersViewModel {
    let whispers: [PrivateWhisper]

    init(whispers: [PrivateWhisper] = PrivateWhisperService().loadWhispers()) {
        self.whispers = whispers
    }

    var featuredWhisper: PrivateWhisper? {
        whispers.first
    }
}
