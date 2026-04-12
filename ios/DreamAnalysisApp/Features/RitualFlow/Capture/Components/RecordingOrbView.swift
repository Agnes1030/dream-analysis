import SwiftUI

struct RecordingOrbView: View {
    var isRecording: Bool

    var body: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color.white.opacity(isRecording ? 0.95 : 0.75),
                            Color(red: 0.67, green: 0.57, blue: 0.92).opacity(isRecording ? 0.95 : 0.6),
                            Color(red: 0.28, green: 0.18, blue: 0.44).opacity(0.85)
                        ],
                        center: .center,
                        startRadius: 12,
                        endRadius: 120
                    )
                )
                .frame(width: 176, height: 176)
                .shadow(color: Color(red: 0.58, green: 0.48, blue: 0.86).opacity(0.35), radius: 28)
                .overlay {
                    Circle()
                        .stroke(Color.white.opacity(0.35), lineWidth: 1)
                        .padding(8)
                }
                .scaleEffect(isRecording ? 1.04 : 0.96)
                .animation(.easeInOut(duration: 1.8).repeatForever(autoreverses: true), value: isRecording)

            Image(systemName: isRecording ? "waveform" : "mic.fill")
                .font(.system(size: 34, weight: .medium))
                .foregroundStyle(Color(red: 0.16, green: 0.10, blue: 0.28))
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(isRecording ? "Recording in progress" : "Ready to record")
    }
}

#Preview {
    ZStack {
        Color.black.opacity(0.85).ignoresSafeArea()
        RecordingOrbView(isRecording: true)
    }
}
