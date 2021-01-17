//
//  PasswordViewModel.swift
//  BlazeChat
//
//  Created by Stefano on 17.01.21.
//

import Foundation

final class InitializeWalletViewModel {
    
    weak var output: InitializeWalletViewModelOutput?
    weak var moduleOutput: InitializeWalletModuleOutput?
    let errorMessage = "Password is invalid."
    
    private let maxDigits = 8
    private var passwordDigits: [Int] = []
    private let seed: [String]
    private let walletService: WalletServiceable
    
    init(walletService: WalletServiceable,
         seed: [String]) {
        self.walletService = walletService
        self.seed = seed
    }
}

// MARK: - Input

extension InitializeWalletViewModel: InitializeWalletViewModelInput {
    
    func setPassword(digit: Int) {
        // TODO: Properly handle invalid password
        passwordDigits.append(digit)
        output?.didUpdatePassword(length: passwordDigits.count)
        
        guard passwordDigits.count >= maxDigits else { return }
        
        let passwordString = String(passwordDigits.reduce(0, { $0 * 10 + $1 }))
        walletService.initializeWalletWith(password: passwordString, seed: seed) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.moduleOutput?.initializeWalletDidSucceed()
            case .failure:
                self.moduleOutput?.initializeWalletDidFail()
            }
        }
    }
    
    func deletePasswordDigit() {
        let _ = passwordDigits.popLast()
        output?.didUpdatePassword(length: passwordDigits.count)
    }
}

// MARK: - Private

private extension InitializeWalletViewModel {
    
    private func initializeWalletWith(password: String) {
        walletService.initializeWalletWith(password: password, seed: []) { [weak self] result in
            // TODO: move to main thread should be done in LightningKit
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success:
                    self.moduleOutput?.initializeWalletDidSucceed()
                case .failure:
                    self.moduleOutput?.initializeWalletDidFail()
                }
            }
        }
    }
}

enum InitializeWalletErrorMessage: String {
    case unkown = "Password is invalid."
}
