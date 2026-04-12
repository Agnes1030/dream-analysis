import SwiftUI

struct RecurringCueStrip: View {
    private let cues = ["water", "home", "searching"]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Quiet continuities")
                .font(.caption.weight(.semibold))
                .textCase(.uppercase)
                .foregroundStyle(Color.white.opacity(0.62))

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(cues, id: \.self) { cue in
                        Text(cue)
                            .font(.subheadline)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 10)
                            .background(Color.white.opacity(0.08))
                            .clipShape(Capsule())
                            .overlay(
                                Capsule()
                                    .stroke(Color.white.opacity(0.10), lineWidth: 1)
                            )
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    RecurringCueStrip()
        .padding()
        .background(Color.black)
}
