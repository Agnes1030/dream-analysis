import SwiftUI

struct DreamCaptureView: View {
    let environment: AppEnvironment
    @State private var viewModel: DreamCaptureViewModel

    init(
        environment: AppEnvironment = .preview(),
        viewModel: DreamCaptureViewModel? = nil
    ) {
        self.environment = environment
        _viewModel = State(
            initialValue: viewModel ?? DreamCaptureViewModel(
                audioRecordingService: environment.audioRecordingService,
                speechTranscriptionService: environment.speechTranscriptionService
            )
        )
    }

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.05, green: 0.06, blue: 0.13),
                        Color(red: 0.12, green: 0.10, blue: 0.24),
                        Color(red: 0.24, green: 0.18, blue: 0.34)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 28) {
                    Spacer(minLength: 12)

                    VStack(spacing: 12) {
                        Text("Tell your dream in your own way")
                            .font(.title2.weight(.semibold))
                            .foregroundStyle(.white)

                        Text(helperCopy)
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(Color.white.opacity(0.82))
                            .padding(.horizontal, 20)
                    }

                    RecordingOrbView(isRecording: viewModel.isRecording)
                        .padding(.vertical, 8)

                    Button(primaryButtonTitle) {
                        Task {
                            if viewModel.isRecording {
                                await viewModel.stopCapture()
                            } else {
                                await viewModel.startCapture()
                            }
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color(red: 0.81, green: 0.74, blue: 0.98))
                    .foregroundStyle(Color(red: 0.16, green: 0.10, blue: 0.28))

                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .font(.footnote)
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(Color.white.opacity(0.86))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(16)
                            .background(Color.white.opacity(0.10))
                            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Transcript")
                            .font(.headline)
                            .foregroundStyle(.white.opacity(0.92))

                        TextEditor(text: $viewModel.transcript)
                            .scrollContentBackground(.hidden)
                            .frame(minHeight: 180)
                            .padding(14)
                            .background(Color.white.opacity(0.14))
                            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                            .foregroundStyle(.white)
                    }

                    Button("Continue with this dream") {
                        Task {
                            await viewModel.stopCapture()
                            environment.ritualFlowCoordinator.continueFromCapture(viewModel.finishCapture())
                        }
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                    .foregroundStyle(Color.white.opacity(0.94))

                    Spacer()
                }
                .padding(24)
            }
            .navigationTitle("Dream capture")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Close") {
                        Task {
                            await viewModel.stopCapture()
                            environment.ritualFlowCoordinator.cancelFlow()
                        }
                    }
                    .foregroundStyle(Color.white.opacity(0.88))
                }
            }
        }
    }

    private var primaryButtonTitle: String {
        viewModel.isRecording ? "Pause for now" : "Begin speaking"
    }

    private var helperCopy: String {
        switch viewModel.captureState {
        case .idle:
            return "Take your time. You can start anywhere, and small details are welcome too."
        case .requestingPermissions:
            return "I’ll ask gently for access before I begin listening."
        case .listening:
            return "I’m listening now. Let the dream arrive in its own shape."
        case .processing:
            return "Holding the last few words for a moment so they can settle into the page."
        case .completed:
            return "Your words have settled here. You can continue speaking or shape the text below."
        case let .failed(message):
            return message
        }
    }
}

#Preview {
    DreamCaptureView(environment: .preview())
}
