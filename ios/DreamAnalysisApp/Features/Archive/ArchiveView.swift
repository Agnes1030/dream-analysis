import SwiftUI

struct ArchiveView: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Archive")
                .font(.title2.weight(.semibold))
            Text("Saved dreams can rest here for a later return.")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

#Preview {
    ArchiveView()
}
