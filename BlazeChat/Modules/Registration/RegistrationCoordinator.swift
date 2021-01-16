//
//  RegistrationCoordinator.swift
//  BlazeChat
//
//  Created by Stefano on 16.01.21.
//

import LightningKitUI
import UIKit

final class RegistrationFlowCoordinator {
    
    private var seed: [String]?
    private let factory = RegistrationFactory()
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = factory.makeSeedView(output: self)
        navigationController.pushViewController(viewController, animated: true)
    }
}

// MARK: - SeedModuleOutput

extension RegistrationFlowCoordinator: SeedModuleOutput {
    
    func didConfirm(seed: [String]) {
        
    }
}
