//
//  SeedModule.swift
//  BlazeChat
//
//  Created by Stefano on 17.01.21.
//

protocol SeedViewModelInput {
    func generateSeed()
    func confirmSeed()
}

protocol SeedViewModelOutput: AnyObject {
    func didGenerate(seed: [String])
}

protocol SeedModuleOutput: AnyObject {
    func didConfirm(seed: [String])
    func generateSeedDidFail()
}
