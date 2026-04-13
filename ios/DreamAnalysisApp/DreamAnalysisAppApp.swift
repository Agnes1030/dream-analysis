import SwiftUI

@main
struct DreamAnalysisAppApp: App {
    private let environment = AppEnvironment.live()

    var body: some Scene {
        WindowGroup {
            AppRootView(environment: environment)
        }
    }
}
