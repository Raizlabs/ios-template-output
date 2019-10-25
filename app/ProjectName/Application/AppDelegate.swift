//
//  AppDelegate.swift
//  ProjectName
//
//  Created by Your Name on 10/25/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var coordinator: AppCoordinator!
    var window: UIWindow?

    // Anything that doesn't rely on the existence of a viewcontroller should be in this preWindowConfigurations array
    let preWindowConfigurations: [AppLifecycle] = [
        LoggingConfiguration(),
        InstabugConfiguration(),
        Appearance.shared,
        CrashReportingConfiguration(),
        AnalyticsConfiguration(),
        DebugMenuConfiguration(),
        StatusBarConfiguration(),
        ]

    // Anything that relies on the existence of a window and an initial viewcontroller should be in this postWindowConfigurations array
    let rootViewControllerDependentConfigurations: [AppLifecycle] = [
        ]

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Don't load the main UI if we're unit testing.
        if let _: AnyClass = NSClassFromString("XCTest") {
            return true
        }

        for config in preWindowConfigurations where config.isEnabled {
            config.onDidLaunch(application: application, launchOptions: launchOptions)
        }

        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        self.coordinator = AppCoordinator(window: window)
        coordinator.start(animated: true, completion: {
            for config in self.rootViewControllerDependentConfigurations where config.isEnabled {
                config.onDidLaunch(application: application, launchOptions: launchOptions)
            }
        })

        return true
    }

}
