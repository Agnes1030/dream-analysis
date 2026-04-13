import SwiftUI

struct CoreInsightCard: View {
    let text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Core insight")
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
    CoreInsightCard(text: "You may be trying to see your life from a little farther away.")
        .padding()
        .background(Color.black)
}
