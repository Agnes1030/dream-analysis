import SwiftUI
import UIKit
import XCTest
@testable import DreamAnalysisApp

@MainActor
final class AppLaunchSmokeTests: XCTestCase {
    func testAppLaunchesIntoFourTabShell() {
        let environment = AppEnvironment.preview()
        environment.ritualFlowCoordinator.finishResult()

        let hostingController = UIHostingController(
            rootView: AppRootView(environment: environment)
        )
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = hostingController
        window.makeKeyAndVisible()
        hostingController.loadViewIfNeeded()
        hostingController.view.layoutIfNeeded()

        let tabBarController = findTabBarController(in: hostingController)

        XCTAssertNotNil(tabBarController)
        XCTAssertEqual(tabBarController?.tabBar.items?.map(\.title), AppTab.allCases.map(\.title))
    }

    private func findTabBarController(in viewController: UIViewController) -> UITabBarController? {
        if let tabBarController = viewController as? UITabBarController {
            return tabBarController
        }

        for child in viewController.children {
            if let tabBarController = findTabBarController(in: child) {
                return tabBarController
            }
        }

        if let presentedViewController = viewController.presentedViewController {
            return findTabBarController(in: presentedViewController)
        }

        return nil
    }
}
