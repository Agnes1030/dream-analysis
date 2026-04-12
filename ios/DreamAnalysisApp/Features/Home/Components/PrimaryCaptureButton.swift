import SwiftUI

struct PrimaryCaptureButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: "waveform.circle.fill")
                    .font(.title3)

                VStack(alignment: .leading, spacing: 3) {
                    Text("Tell tonight's dream")
                        .font(.headline)
                    Text("Start softly when you're ready")
                        .font(.subheadline)
                        .foregroundStyle(Color.white.opacity(0.82))
                }

                Spacer()

                Image(systemName: "arrow.right")
                    .font(.headline.weight(.semibold))
            }
            .foregroundStyle(.white)
            .padding(.horizontal, 18)
            .padding(.vertical, 18)
            .background(
                LinearGradient(
                    colors: [Color(red: 0.39, green: 0.33, blue: 0.67), Color(red: 0.28, green: 0.23, blue: 0.52)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .stroke(Color.white.opacity(0.14), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.18), radius: 16, y: 8)
        }
        .buttonStyle(.plain)
        .accessibilityIdentifier("home.primaryCaptureButton")
    }
}

#Preview {
    PrimaryCaptureButton(action: {})
        .padding()
        .background(Color.black)
}
