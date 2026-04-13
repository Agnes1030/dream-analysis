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
                        title: "How your dream story is moving",
                        summary: viewModel.patternSummary.trajectorySummary,
                        shouldExplainGrowth: viewModel.shouldExplainGrowth
                    )

                    if !viewModel.patternSummary.recurringSymbols.isEmpty {
                        RecurringSymbolsSection(symbols: viewModel.patternSummary.recurringSymbols)
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

#Preview {
    PatternsView()
}
