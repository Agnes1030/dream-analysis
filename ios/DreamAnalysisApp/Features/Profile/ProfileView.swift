import SwiftUI

struct ProfileView: View {
    private let viewModel = ProfileViewModel()

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    hero

                    MemoryControlsSection(viewModel: viewModel)
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .navigationTitle("Me")
            .background(Color(.systemBackground))
        }
    }

    private var hero: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("A quiet place to understand what stays with you.")
                .font(.system(.title2, design: .serif, weight: .semibold))

            Text("These notes help explain how your dreams are remembered, protected, and carried gently from one reflection to the next.")
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
    ProfileView()
}
