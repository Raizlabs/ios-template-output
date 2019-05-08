//
//  StatusBarConfiguration.swift
//  ProjectName
//
//  Created by Zev Eisenberg on 4/3/18.
//  Copyright © 2018 Raizlabs. All rights reserved.
//

#if targetEnvironment(simulator) && DEBUG
    import SimulatorStatusMagic
#endif

struct StatusBarConfiguration: AppLifecycle {

    var isEnabled: Bool {
        return ProcessInfo.isRunningUITests
    }

    func onDidLaunch(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        #if targetEnvironment(simulator) && DEBUG
            SDStatusBarManager.sharedInstance().enableOverrides()
        #endif
    }

}
