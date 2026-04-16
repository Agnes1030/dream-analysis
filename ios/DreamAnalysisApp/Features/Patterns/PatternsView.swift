import SwiftUI

struct PatternsView: View {
    @State private var viewModel: PatternsViewModel

    init(viewModel: PatternsViewModel = PatternsViewModel(patternSummary: PatternSummaryService().loadSummary())) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    hero

                    TrajectorySummaryBlock(
                        title: viewModel.trajectoryTitle,
                        summary: viewModel.patternSummary.trajectorySummary,
                        shouldExplainGrowth: viewModel.shouldExplainGrowth
                    )

                    if let recentThemeSummary = viewModel.recentThemeSummary {
                        ReflectionSection(
                            title: "What has been surfacing lately",
                            bodyText: recentThemeSummary
                        )
                    }

                    if !viewModel.recurringSymbols.isEmpty {
                        RecurringSymbolsSection(symbols: viewModel.recurringSymbols)
                    }

                    if !viewModel.peoplePlacesRows.isEmpty {
                        PeoplePlacesSection(rows: viewModel.peoplePlacesRows)
                    }

                    if let emotionalTrendSummary = viewModel.emotionalTrendSummary {
                        ReflectionSection(
                            title: "How the feeling tone is changing",
                            bodyText: emotionalTrendSummary
                        )
                    }

                    if let profileReflection = viewModel.profileReflection {
                        ReflectionSection(
                            title: "An evolving reflection",
                            bodyText: profileReflection
                        )
                    }
                }
                .padding(20)
            }
            .navigationTitle("Patterns")
            .background(Color(.systemBackground))
        }
    }

    private var hero: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(viewModel.patternSummary.title)
                .font(.system(.title2, design: .serif, weight: .semibold))

            Text(viewModel.patternSummary.detail)
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(24)
        .background(Color(.tertiarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
    }
}

private struct ReflectionSection: View {
    let title: String
    let bodyText: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.primary)

            Text(bodyText)
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
    }
}

private struct PeoplePlacesSection: View {
    let rows: [PatternsViewModel.PeoplePlacesRow]

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Recurring people and places")
                .font(.headline)

            VStack(alignment: .leading, spacing: 16) {
                ForEach(Array(rows.enumerated()), id: \.offset) { _, row in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(row.title)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.primary)

                        Text(row.items.joined(separator: ", "))
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(18)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    PatternsView()
}
