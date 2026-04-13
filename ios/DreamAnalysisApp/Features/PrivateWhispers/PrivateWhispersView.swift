import SwiftUI

struct PrivateWhispersView: View {
    @State private var viewModel: PrivateWhispersViewModel

    init(viewModel: PrivateWhispersViewModel = PrivateWhispersViewModel()) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    header

                    if let featuredWhisper = viewModel.featuredWhisper {
                        featuredCard(featuredWhisper)
                    }
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .navigationTitle("Private Whispers")
            .background(Color(.systemBackground))
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("A single note that may matter more than a longer list.")
                .font(.system(.title2, design: .serif, weight: .semibold))

            Text("When a dream pattern feels unusually specific, this space can hold one quiet reflection without turning it into a stream.")
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(24)
        .background(Color(.tertiarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
    }

    private func featuredCard(_ whisper: PrivateWhisper) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Featured whisper")
                .font(.caption.weight(.semibold))
                .textCase(.uppercase)
                .foregroundStyle(.secondary)

            Text(whisper.featuredText)
                .font(.title3.weight(.semibold))
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(24)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
    }
}

#Preview {
    PrivateWhispersView()
}
