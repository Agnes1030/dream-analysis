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
        TabView(selection: $state.selectedTab) {
            HomeView()
                .tabItem {
                    Label(AppTab.home.title, systemImage: AppTab.home.systemImageName)
                }
                .tag(AppTab.home)

            PatternsView()
                .tabItem {
                    Label(AppTab.patterns.title, systemImage: AppTab.patterns.systemImageName)
                }
                .tag(AppTab.patterns)

            ArchiveView()
                .tabItem {
                    Label(AppTab.archive.title, systemImage: AppTab.archive.systemImageName)
                }
                .tag(AppTab.archive)

            ProfileView()
                .tabItem {
                    Label(AppTab.me.title, systemImage: AppTab.me.systemImageName)
                }
                .tag(AppTab.me)
        }
        .tint(Color(red: 0.45, green: 0.37, blue: 0.72))
    }
}

#Preview {
    AppRootView()
}
