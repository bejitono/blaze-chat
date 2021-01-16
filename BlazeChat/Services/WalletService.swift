//
//  WalletService.swift
//  BlazeChat
//
//  Created by Stefano on 16.01.21.
//

import LightningKit

protocol WalletServiceable {
    func generateSeed(completion: @escaping (Result<LNSSeed, Error>) -> Void)
}

final class WalletService: WalletServiceable {
    
    private let walletService: LKWallet
    
    init(walletService: LKWallet) {
        self.walletService = walletService
    }
    
    func generateSeed(completion: @escaping (Result<LNSSeed, Error>) -> Void) {
        walletService.generateSeed(completion: completion)
    }
}
