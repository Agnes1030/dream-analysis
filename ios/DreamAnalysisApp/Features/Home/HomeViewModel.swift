import Observation

@Observable
final class HomeViewModel {
    var isPresentingCapture = false

    func didTapCapture() {
        isPresentingCapture = true
    }
}
