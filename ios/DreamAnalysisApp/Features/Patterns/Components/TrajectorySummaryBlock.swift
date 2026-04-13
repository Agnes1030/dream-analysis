import SwiftUI

struct TrajectorySummaryBlock: View {
    let title: String
    let summary: String
    let shouldExplainGrowth: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.primary)

            Text(summary)
                .font(.body)
                .foregroundStyle(.secondary)

            if shouldExplainGrowth {
                Text("As more dreams gather here, this view will start to show how your symbols and feelings move together over time.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
    }
}

#Preview {
    TrajectorySummaryBlock(
        title: "How things are evolving",
        summary: "A few images are starting to recur in a gentle way.",
        shouldExplainGrowth: true
    )
    .padding()
}
