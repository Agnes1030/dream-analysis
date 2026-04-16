import Observation

@Observable
final class HomeViewModel {
    func didTapCapture(using coordinator: RitualFlowCoordinator) {
        coordinator.startCapture()
    }
}
