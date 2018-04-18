//
//  SignInCoordinator.swift
//  ProjectName
//
//  Created by Your Name on 3/27/17.
//  Copyright © 2017 Raizlabs. All rights reserved.
//

import UIKit
import Services

class SignInCoordinator: Coordinator {

    let baseController: UIViewController
    var childCoordinator: Coordinator?
    weak var delegate: Delegate?

    init(_ baseController: UIViewController) {
        self.baseController = baseController
    }

    func start(animated: Bool, completion: VoidClosure?) {
        // TODO - create and use SignInViewController
        let vc = UIViewController()
        vc.view.backgroundColor = .red
        self.baseController.present(vc, animated: animated, completion: completion)
    }

    func cleanup(animated: Bool, completion: VoidClosure?) {
        baseController.dismiss(animated: animated, completion: completion)
    }

}

extension SignInCoordinator: Actionable {

    enum Action {
        case didSignIn
    }

}
