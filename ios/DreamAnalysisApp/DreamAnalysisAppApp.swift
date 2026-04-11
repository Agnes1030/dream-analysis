import SwiftUI

@main
struct DreamAnalysisAppApp: App {
    private let environment = AppEnvironment()

    var body: some Scene {
        WindowGroup {
            AppRootView(environment: environment)
        }
    }
}
