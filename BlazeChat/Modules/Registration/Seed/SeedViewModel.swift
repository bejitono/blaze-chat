//
//  SeedViewModel.swift
//  BlazeChat
//
//  Created by Stefano on 16.01.21.
//

import Foundation

final class SeedViewModel {
    
    weak var output: SeedViewModelOutput?
    weak var moduleOutput: SeedModuleOutput?
    
    private var seed: [String]?
    private let walletService: WalletServiceable
    
    init(walletService: WalletServiceable) {
        self.walletService = walletService
    }
}

// MARK: - Input

extension SeedViewModel: SeedViewModelInput {
    
    func generateSeed() {
        walletService.generateSeed { [weak self] result in
            // TODO: move to main thread should be done in LightningKit
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let seed):
                    self.seed = seed.phrase
                    self.output?.didGenerate(seed: seed.phrase)
                case .failure:
                    self.moduleOutput?.generateSeedDidFail()
                }
            }
        }
    }
    
    func confirmSeed() {
        guard let seed = seed else { return assertionFailure()}
        moduleOutput?.didConfirm(seed: seed)
    }
}
