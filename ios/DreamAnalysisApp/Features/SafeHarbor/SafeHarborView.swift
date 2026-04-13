import SwiftUI

struct SafeHarborView: View {
    @State private var viewModel: SafeHarborViewModel

    init(viewModel: SafeHarborViewModel = SafeHarborViewModel()) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    header

                    if let primaryItem = viewModel.primaryItem {
                        primaryCard(primaryItem)
                    }

                    if !viewModel.secondaryItems.isEmpty {
                        secondarySection
                    }
                }
                .padding(20)
            }
            .navigationTitle("Safe Harbor")
            .background(Color(.systemBackground))
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("A quieter place to land, if you need one.")
                .font(.system(.title2, design: .serif, weight: .semibold))

            Text("These small refuge prompts are here to help the feeling settle before you move on.")
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(24)
        .background(Color(.tertiarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
    }

    private func primaryCard(_ item: SafeHarborItem) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Begin here")
                .font(.caption.weight(.semibold))
                .textCase(.uppercase)
                .foregroundStyle(.secondary)

            Text(item.title)
                .font(.title3.weight(.semibold))

            Text(item.detail)
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(24)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
    }

    private var secondarySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("If you want another gentle option")
                .font(.headline)
                .foregroundStyle(.secondary)

            ForEach(viewModel.secondaryItems.indices, id: \.self) { index in
                let item = viewModel.secondaryItems[index]
                VStack(alignment: .leading, spacing: 8) {
                    Text(item.title)
                        .font(.body.weight(.medium))

                    Text(item.detail)
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(18)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            }
        }
    }
}

#Preview {
    SafeHarborView()
}
