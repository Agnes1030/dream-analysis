import SwiftUI

struct PatternsView: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Patterns")
                .font(.title2.weight(.semibold))
            Text("Recurring symbols and feelings can gather here over time.")
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
    PatternsView()
}
