//
//  InitializeWalletModule.swift
//  BlazeChat
//
//  Created by Stefano on 17.01.21.
//

protocol InitializeWalletViewModelInput {
    func setPassword(digit: Int)
    func deletePasswordDigit()
}

protocol InitializeWalletViewModelOutput: AnyObject {
    func didUpdatePassword(length: Int)
    func didReceiveInvalidPassword(length: Int, message: InitializeWalletErrorMessage)
}

protocol InitializeWalletModuleOutput: AnyObject {
    func initializeWalletDidSucceed()
    func initializeWalletDidFail()
}
