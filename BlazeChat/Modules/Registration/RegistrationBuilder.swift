//
//  RegistrationBuilder.swift
//  BlazeChat
//
//  Created by Stefano on 16.01.21.
//

import LightningKit
import UIKit

struct RegistrationFactory {
    
    func makeSeedView(output: SeedModuleOutput) -> UIViewController {
        let service = WalletService(walletService: LKWallet.shared)
        let viewModel = SeedViewModel(walletService: service)
        let view = SeedViewController(viewModel: viewModel)
        
        viewModel.output = view
        viewModel.moduleOutput = output
        
        return view
    }
    
    func makeInitalizeWalletView(output: InitializeWalletModuleOutput, seed: [String]) -> UIViewController {
        let service = WalletService(walletService: LKWallet.shared)
        let viewModel = InitializeWalletViewModel(walletService: service, seed: seed)
        let view = InitializeWalletViewController(viewModel: viewModel)
        
        viewModel.output = view
        viewModel.moduleOutput = output
        
        return view
    }
}
