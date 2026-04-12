import SwiftUI

struct DreamCaptureView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = DreamCaptureViewModel()

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

                        Text("Take your time. You can start anywhere, and small details are welcome too.")
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(Color.white.opacity(0.82))
                            .padding(.horizontal, 20)
                    }

                    RecordingOrbView(isRecording: viewModel.isRecording)
                        .padding(.vertical, 8)

                    Button(viewModel.isRecording ? "Pause for now" : "Begin speaking") {
                        if viewModel.isRecording {
                            viewModel.stopCapture()
                        } else {
                            viewModel.startCapture()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color(red: 0.81, green: 0.74, blue: 0.98))
                    .foregroundStyle(Color(red: 0.16, green: 0.10, blue: 0.28))

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
                        _ = viewModel.finishCapture()
                        dismiss()
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
                        dismiss()
                    }
                    .foregroundStyle(Color.white.opacity(0.88))
                }
            }
        }
    }
}

#Preview {
    DreamCaptureView()
}
