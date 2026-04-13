import SwiftUI

struct PersonalizedReflectionCard: View {
    let text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Personal reflection")
                .font(.headline)
                .foregroundStyle(.white)

            Text(text)
                .font(.body)
                .foregroundStyle(Color.white.opacity(0.84))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(22)
        .background(Color.white.opacity(0.06))
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(Color.white.opacity(0.08), lineWidth: 1)
        )
    }
}

#Preview {
    PersonalizedReflectionCard(text: "There may be a quiet wish here for more steadiness, or for a little more room to feel what has been building.")
        .padding()
        .background(Color.black)
}
