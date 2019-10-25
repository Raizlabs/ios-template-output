//
//  DebugMenuConfiguration.swift
//  ProjectName
//
//  Created by Your Name on 10/25/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import UIKit
import Swiftilities
import Services

class DebugMenuConfiguration: AppLifecycle {

    var isEnabled: Bool {
        return BuildType.active == .internal || BuildType.active == .debug
    }

    func onDidLaunch(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        DefaultBehaviors(behaviors: [DebugMenuBehavior()]).inject()
    }

}

public class DebugMenuBehavior: ViewControllerLifecycleBehavior {

    public init() {}
    public func afterAppearing(_ viewController: UIViewController, animated: Bool) {
        DebugMenu.enableDebugGesture(viewController)
    }

}
