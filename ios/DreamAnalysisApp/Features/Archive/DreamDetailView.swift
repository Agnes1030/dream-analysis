import SwiftUI

struct DreamDetailView: View {
    let dream: DreamEntry

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                headerCard
                interpretationSection
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 24)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Dream")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var headerCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(formattedDate)
                .font(.caption.weight(.semibold))
                .textCase(.uppercase)
                .foregroundStyle(.secondary)

            Text(dream.rawTranscript)
                .font(.title3.weight(.semibold))
                .foregroundStyle(.primary)

            if let followUpAnswer = dream.followUpAnswer, !followUpAnswer.isEmpty {
                Text(followUpAnswer)
                    .font(.body)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
    }

    private var interpretationSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Reflection")
                .font(.headline)

            Text("A saved dream can stay here as a gentle record of what moved through you that day.")
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
    }

    private var formattedDate: String {
        dream.createdAt.formatted(date: .abbreviated, time: .omitted)
    }
}

#Preview {
    let dream = DreamEntry(rawTranscript: "I was walking through a blue garden at night.")
    dream.followUpAnswer = "It felt quiet, but not lonely."

    return NavigationStack {
        DreamDetailView(dream: dream)
    }
}
