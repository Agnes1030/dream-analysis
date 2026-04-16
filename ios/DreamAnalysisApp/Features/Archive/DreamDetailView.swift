import SwiftUI

struct DreamDetailView: View {
    let dream: DreamEntry

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                overviewCard
                if hasContent(details: detailSections) {
                    detailCard
                }
                reflectionCard
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 24)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Dream")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var overviewCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(formattedDate)
                .font(.caption.weight(.semibold))
                .textCase(.uppercase)
                .foregroundStyle(.secondary)

            if !metadataLine.isEmpty {
                Text(metadataLine)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Transcript")
                    .font(.headline)

                Text(dream.rawTranscript)
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(.primary)
            }

            if let followUpAnswer = trimmed(dream.followUpAnswer) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("What stayed with you")
                        .font(.headline)

                    Text(followUpAnswer)
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
    }

    private var detailCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let interpretationSummary = trimmed(dream.interpretationSummary) {
                detailSection(title: "Saved interpretation", body: interpretationSummary)
            }

            if let reflectionSnippet = trimmed(dream.reflectionSnippet) {
                detailSection(title: "Symbolic reflection", body: reflectionSnippet)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
    }

    private var reflectionCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Reflection")
                .font(.headline)

            Text("A saved dream can stay here as part of an unfolding history, keeping the images, feeling, and meaning that were most alive when you met it.")
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

    private var metadataLine: String {
        let markers = [
            !dream.emotionalMarkers.isEmpty ? "Emotional markers: \(dream.emotionalMarkers.joined(separator: ", "))" : nil,
            !dream.tags.isEmpty ? "Tags: \(dream.tags.joined(separator: ", "))" : nil
        ].compactMap { $0 }

        return markers.joined(separator: "  •  ")
    }

    private var detailSections: [String?] {
        [dream.interpretationSummary, dream.reflectionSnippet]
    }

    private func detailSection(title: String, body: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)

            Text(body)
                .font(.body)
                .foregroundStyle(.secondary)
        }
    }

    private func trimmed(_ value: String?) -> String? {
        guard let value else {
            return nil
        }

        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? nil : trimmed
    }

    private func hasContent(details: [String?]) -> Bool {
        details.contains { trimmed($0) != nil }
    }
}

#Preview {
    let dream = DreamEntry(
        rawTranscript: "I was walking through a blue garden at night.",
        followUpAnswer: "It felt quiet, but not lonely.",
        interpretationSummary: "The garden may reflect a part of you returning to something tender and still alive.",
        reflectionSnippet: "Blue can sometimes carry calm, distance, or a longing that wants to be listened to.",
        tags: ["garden", "night"],
        emotionalMarkers: ["quiet", "tender"]
    )

    return NavigationStack {
        DreamDetailView(dream: dream)
    }
}
