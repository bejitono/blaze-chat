//
//  RegistrationCoordinator.swift
//  BlazeChat
//
//  Created by Stefano on 16.01.21.
//

import LightningKitUI
import UIKit

final class RegistrationFlowCoordinator {
    
    private let factory = RegistrationFactory()
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = factory.makeSeedView(output: self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToPasswordViewWith(seed: [String]) {
        let viewController = factory.makeInitalizeWalletView(output: self, seed: seed)
        navigationController.pushViewController(viewController, animated: true)
    }
}

// MARK: - SeedModuleOutput

extension RegistrationFlowCoordinator: SeedModuleOutput {
    
    func didConfirm(seed: [String]) {
        goToPasswordViewWith(seed: seed)
    }
    
    func generateSeedDidFail() {
        // TODO: Handle failure
    }
}

// MARK: - InitializeWalletModuleOutput

extension RegistrationFlowCoordinator: InitializeWalletModuleOutput {
    
    func initializeWalletDidSucceed() {
        print("*******Succeeded wallet initialization**********")
    }
    
    func initializeWalletDidFail() {
        // TODO: Handle failure
        print("*******Failed wallet initialization**********")
    }
}

