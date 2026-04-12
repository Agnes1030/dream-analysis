import SwiftUI

struct RecentDreamCallbackCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("A recent thread")
                .font(.caption.weight(.semibold))
                .textCase(.uppercase)
                .foregroundStyle(Color.white.opacity(0.62))

            Text("Last time, the dream lingered around a quiet house and the feeling of looking for someone.")
                .font(.body)
                .foregroundStyle(.white)

            Text("You can begin there again, or start somewhere entirely new.")
                .font(.subheadline)
                .foregroundStyle(Color.white.opacity(0.72))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(Color.white.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Color.white.opacity(0.10), lineWidth: 1)
        )
    }
}

#Preview {
    RecentDreamCallbackCard()
        .padding()
        .background(Color.black)
}
