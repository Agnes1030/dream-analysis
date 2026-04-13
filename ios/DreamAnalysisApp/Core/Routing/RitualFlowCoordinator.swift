import Observation

@Observable
final class RitualFlowCoordinator {
    var isPresentingFlow = true

    func finishResult() {
        isPresentingFlow = false
    }
}
