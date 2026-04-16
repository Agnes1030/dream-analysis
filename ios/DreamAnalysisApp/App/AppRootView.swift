import SwiftUI

struct AppRootState {
    enum RitualFlowRoute: Equatable {
        case capture
        case followUp(FollowUpPrompt)
        case analyzing
        case result(DreamEntry, Interpretation)
    }

    var selectedTab: AppTab = .home

    func ritualFlowBinding(for environment: AppEnvironment) -> Binding<Bool> {
        Binding(
            get: { environment.ritualFlowCoordinator.isPresentingFlow },
            set: { isPresenting in
                if isPresenting == false {
                    environment.ritualFlowCoordinator.cancelFlow()
                }
            }
        )
    }

    func ritualFlowRoute(for environment: AppEnvironment) -> RitualFlowRoute? {
        guard environment.ritualFlowCoordinator.isPresentingFlow else {
            return nil
        }

        switch environment.ritualFlowCoordinator.step {
        case .capture:
            return .capture
        case .followUp:
            guard let prompt = environment.ritualFlowCoordinator.followUpPrompt else {
                return nil
            }
            return .followUp(prompt)
        case .analyzing:
            return .analyzing
        case .result:
            guard
                let dream = environment.ritualFlowCoordinator.dream,
                let interpretation = environment.ritualFlowCoordinator.interpretation
            else {
                return nil
            }
            return .result(dream, interpretation)
        }
    }

    func resultCompletionAction(for environment: AppEnvironment) -> () -> Void {
        {
            environment.ritualFlowCoordinator.finishResult()
        }
    }
}

struct AppRootView: View {
    let environment: AppEnvironment
    @State private var state = AppRootState()

    init(environment: AppEnvironment = .live()) {
        self.environment = environment
    }

    var body: some View {
        TabView(selection: $state.selectedTab) {
            HomeView(environment: environment)
                .tabItem {
                    Label(AppTab.home.title, systemImage: AppTab.home.systemImageName)
                }
                .tag(AppTab.home)

            PatternsView()
                .tabItem {
                    Label(AppTab.patterns.title, systemImage: AppTab.patterns.systemImageName)
                }
                .tag(AppTab.patterns)

            ArchiveView()
                .tabItem {
                    Label(AppTab.archive.title, systemImage: AppTab.archive.systemImageName)
                }
                .tag(AppTab.archive)

            ProfileView()
                .tabItem {
                    Label(AppTab.me.title, systemImage: AppTab.me.systemImageName)
                }
                .tag(AppTab.me)
        }
        .tint(Color(red: 0.45, green: 0.37, blue: 0.72))
        .sheet(isPresented: state.ritualFlowBinding(for: environment)) {
            ritualFlowView
        }
    }

    @ViewBuilder
    private var ritualFlowView: some View {
        switch state.ritualFlowRoute(for: environment) {
        case .capture:
            DreamCaptureView(environment: environment)
        case .followUp(let prompt):
            FollowUpView(
                viewModel: FollowUpViewModel(prompt: prompt),
                onSkip: {
                    environment.ritualFlowCoordinator.continueFromFollowUp(answer: nil)
                },
                onSelectOption: { option in
                    environment.ritualFlowCoordinator.continueFromFollowUp(answer: option)
                },
                onSubmitText: { answer in
                    environment.ritualFlowCoordinator.continueFromFollowUp(answer: answer)
                }
            )
        case .analyzing:
            RitualFlowLoadingView(onAppear: {
                environment.ritualFlowCoordinator.finishAnalyzing()
            })
        case .result(let dream, let interpretation):
            InterpretationResultView(
                viewModel: InterpretationResultViewModel(
                    dream: dream,
                    interpretation: interpretation
                ),
                onComplete: state.resultCompletionAction(for: environment)
            )
        case nil:
            EmptyView()
        }
    }
}

private struct RitualFlowLoadingView: View {
    let onAppear: () -> Void

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.05, green: 0.05, blue: 0.12),
                        Color(red: 0.12, green: 0.10, blue: 0.24),
                        Color(red: 0.24, green: 0.18, blue: 0.35)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 18) {
                    ProgressView()
                        .tint(.white)
                        .scaleEffect(1.2)

                    Text("Listening for the shape beneath the dream")
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(.white)

                    Text("Holding your words for a brief moment so the first reflection can arrive gently.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.white.opacity(0.80))
                        .padding(.horizontal, 28)
                }
            }
            .navigationTitle("Analyzing")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                try? await Task.sleep(for: .milliseconds(700))
                onAppear()
            }
        }
    }
}

#Preview {
    AppRootView(environment: .preview())
}
