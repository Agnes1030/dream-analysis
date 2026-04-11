import SwiftUI

struct AppRootState {
    var selectedTab: AppTab = .home
}

struct AppRootView: View {
    let environment: AppEnvironment
    @State private var state = AppRootState()

    init(environment: AppEnvironment = AppEnvironment()) {
        self.environment = environment
    }

    var body: some View {
        Text(title(for: state.selectedTab))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(
                    colors: [Color(red: 0.10, green: 0.09, blue: 0.18), Color(red: 0.24, green: 0.19, blue: 0.35)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .foregroundStyle(.white)
    }

    private func title(for tab: AppTab) -> String {
        switch tab {
        case .home:
            return "Begin with the dream"
        case .patterns:
            return "Patterns"
        case .archive:
            return "Archive"
        case .me:
            return "Me"
        }
    }
}

#Preview {
    AppRootView()
}
