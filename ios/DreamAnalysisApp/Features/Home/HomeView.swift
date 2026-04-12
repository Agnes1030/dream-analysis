import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Home")
                .font(.title2.weight(.semibold))
            Text("A quiet place to begin with your dream.")
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
    HomeView()
}
