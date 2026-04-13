import SwiftData
import SwiftUI

struct ArchiveView: View {
    @Query(filter: #Predicate<DreamEntry> { $0.isArchived }, sort: [SortDescriptor(\DreamEntry.createdAt, order: .reverse)])
    private var archivedDreams: [DreamEntry]

    @State private var viewModel = ArchiveViewModel(dreams: [])

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.showsEmptyState {
                    emptyState
                } else {
                    dreamList
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 24)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Archive")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                syncViewModel()
            }
            .onChange(of: archivedDreams) { _, _ in
                syncViewModel()
            }
            .navigationDestination(item: $viewModel.selectedDream) { dream in
                DreamDetailView(dream: dream)
            }
        }
    }

    private var emptyState: some View {
        VStack(spacing: 14) {
            Text("Archive")
                .font(.title2.weight(.semibold))

            Text("Saved dreams can rest here for a later return.")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var dreamList: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Saved dreams")
                    .font(.headline)
                    .foregroundStyle(.secondary)

                ForEach(viewModel.dreams, id: \.id) { dream in
                    Button {
                        viewModel.selectDream(dream)
                    } label: {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(dream.createdAt.formatted(date: .abbreviated, time: .omitted))
                                .font(.caption.weight(.semibold))
                                .textCase(.uppercase)
                                .foregroundStyle(.secondary)

                            Text(dream.rawTranscript)
                                .font(.body.weight(.medium))
                                .foregroundStyle(.primary)
                                .lineLimit(3)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(18)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private func syncViewModel() {
        viewModel.updateDreams(archivedDreams)
    }
}

#Preview {
    ArchiveView()
}
