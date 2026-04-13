import SwiftUI

struct MemoryControlsSection: View {
    let syncExplanation: String
    let privacyExplanation: String
    let memoryExplanation: String

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Memory and privacy")
                .font(.headline)

            explanationRow(
                title: "Sync",
                detail: syncExplanation
            )

            explanationRow(
                title: "Privacy",
                detail: privacyExplanation
            )

            explanationRow(
                title: "Memory",
                detail: memoryExplanation
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
    }

    @ViewBuilder
    private func explanationRow(title: String, detail: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.subheadline.weight(.semibold))

            Text(detail)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    MemoryControlsSection(
        syncExplanation: "Your dream history can stay quietly in step across devices when you choose to keep it.",
        privacyExplanation: "Raw dream details can remain close to you, while only the context needed for interpretation is shared.",
        memoryExplanation: "Memory helps the app notice returning symbols, feelings, and places so each reflection can feel more familiar over time."
    )
    .padding()
}
