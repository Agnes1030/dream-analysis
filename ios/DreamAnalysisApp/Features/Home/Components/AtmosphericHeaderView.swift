import SwiftUI

struct AtmosphericHeaderView: View {
    var body: some View {
        VStack(spacing: 14) {
            Image(systemName: "moon.stars.fill")
                .font(.system(size: 28, weight: .medium))
                .foregroundStyle(
                    LinearGradient(
                        colors: [Color.white.opacity(0.95), Color(red: 0.73, green: 0.66, blue: 0.95)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .padding(18)
                .background(
                    Circle()
                        .fill(Color.white.opacity(0.10))
                )
                .overlay(
                    Circle()
                        .stroke(Color.white.opacity(0.14), lineWidth: 1)
                )

            VStack(spacing: 8) {
                Text("Begin where the dream is still soft")
                    .font(.system(.title2, design: .serif, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)

                Text("Speak it the way it returns to you. Fragments, feelings, and symbols are all welcome here.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.white.opacity(0.78))
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    AtmosphericHeaderView()
        .padding()
        .background(Color.black)
}
