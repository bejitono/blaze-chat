//
//  PasswordViewController.swift
//  BlazeChat
//
//  Created by Stefano on 17.01.21.
//

import LightningKitUI
import UIKit

final class InitializeWalletViewController: UIViewController {
    
    // TODO: Localize
    private let passwordViewController = PasswordViewController(configuration: .init(title: "Create Password", forgotPINTitle: "Forgot password."))
    private let viewModel: InitializeWalletViewModelInput
    
    init(viewModel: InitializeWalletViewModelInput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

// MARK: - InitializeWalletViewModelOutput

extension InitializeWalletViewController: InitializeWalletViewModelOutput {
        
    func didUpdatePassword(length: Int) {
        passwordViewController.set(state: .input(length: length))
    }
    
    func didReceiveInvalidPassword(length: Int, message: InitializeWalletErrorMessage) {
        passwordViewController.set(state: .error(message: message.rawValue, inputLength: length))
    }
}

// MARK: - PasswordViewControllerDelegate

extension InitializeWalletViewController: PasswordViewControllerDelegate {
    
    func pinViewController(_ controller: PasswordViewController, didHandle digit: Int) {
        viewModel.setPassword(digit: digit)
    }
    
    func pinViewControllerDidHandleDelete(_ controller: PasswordViewController) {
        viewModel.deletePasswordDigit()
    }
    
    func pinViewControllerDidHandleForgotPIN(_ controller: PasswordViewController) {
        // TODO: Handle forgot pin
    }
}

// MARK: - View Setup

private extension InitializeWalletViewController {
    
    func setupViews() {
        
        passwordViewController.delegate = self
        passwordViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordViewController.view)
        NSLayoutConstraint.activate([
            passwordViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            passwordViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            passwordViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            passwordViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
