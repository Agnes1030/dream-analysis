import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Me")
                .font(.title2.weight(.semibold))
            Text("A gentle space for your profile and preferences.")
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
    ProfileView()
}
