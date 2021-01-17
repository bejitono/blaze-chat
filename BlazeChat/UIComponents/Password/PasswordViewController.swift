//
//  PasswordViewController.swift
//  BlazeChat
//
//  Created by Stefano on 17.01.21.
//

import LightningKitUI
import UIKit

protocol PasswordViewControllerDelegate: AnyObject {
    func pinViewController(_ controller: PasswordViewController, didHandle digit: Int)
    func pinViewControllerDidHandleDelete(_ controller: PasswordViewController)
    func pinViewControllerDidHandleForgotPIN(_ controller: PasswordViewController)
}

final class PasswordViewController: UIViewController {
    
    enum State {
        case input(length: Int)
        case error(message: String, inputLength: Int)
    }
    
    struct Configuration {
        public let title: String
        public let forgotPINTitle: String
        
        public init(title: String,
                    forgotPINTitle: String) {
            self.title = title
            self.forgotPINTitle = forgotPINTitle
        }
    }
    
    weak var delegate: PasswordViewControllerDelegate?
    
    private let containerStackView = UIStackView()
    private let titleLabel = UILabel()
    private let pinView = PasswordView()
    private let forgotPINButton = UIButton()
    private let keyboardViewController = KeyboardViewController()
    private let configuration: Configuration
    
    init(configuration: Configuration) {
        self.configuration = configuration
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func set(state: State) {
        switch state {
        case .input(length: let inputLength):
            pinView.set(state: .input(length: inputLength))
        case .error(message: let message, inputLength: let inputLength):
            pinView.set(state: .error(message: message,  inputLength: inputLength))
        }
    }
}

// MARK: - Actions

private extension PasswordViewController {
    
    @objc
    func didTapForgotPIN() {
        delegate?.pinViewControllerDidHandleForgotPIN(self)
    }
}

// MARK: - KeyboardViewControllerDelegate

extension PasswordViewController: KeyboardViewControllerDelegate {
    
    func didTap(digit: Int) {
        delegate?.pinViewController(self, didHandle: digit)
    }
    
    func didTapDot() {
        
    }
    
    func didTapDelete() {
        delegate?.pinViewControllerDidHandleDelete(self)
    }
}

// MARK: - View Setup

private extension PasswordViewController {
    
    func setupViews() {
        view.backgroundColor = Theme.color.primaryBackground
        setupContainerStackView()
        setupTitleLabel()
        setupPINDotView()
        setupForgotPINButton()
        setupKeyboardView()
    }
    
    func setupContainerStackView() {
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerStackView)
        NSLayoutConstraint.activate([
            containerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding),
            containerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding),
            containerStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
        
        containerStackView.axis = .vertical
        containerStackView.spacing = .spacing
        containerStackView.alignment = .center
    }
    
    func setupTitleLabel() {
        containerStackView.addArrangedSubview(titleLabel)
        titleLabel.font = Theme.font.headline3
        titleLabel.text = configuration.title
        titleLabel.textAlignment = .center
    }
    
    func setupPINDotView() {
        containerStackView.addArrangedSubview(pinView)
        pinView.heightAnchor.constraint(equalToConstant: .pinDotViewHeight).isActive = true
    }
    
    func setupForgotPINButton() {
        containerStackView.addArrangedSubview(forgotPINButton)
        forgotPINButton.setTitle(configuration.forgotPINTitle, for: .normal)
        forgotPINButton.addTarget(self, action: #selector(didTapForgotPIN), for: .touchUpInside)
        forgotPINButton.setTitleColor(Theme.color.secondary, for: .normal)
        forgotPINButton.setTitleColor(Theme.color.secondary.withAlphaComponent(.forgotPINAlpha), for: .highlighted)
    }
    
    func setupKeyboardView() {
        keyboardViewController.view.backgroundColor = Theme.color.primaryBackground
        keyboardViewController.delegate = self
        containerStackView.addArrangedSubview(keyboardViewController.view)
        NSLayoutConstraint.activate([
            keyboardViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding),
            keyboardViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding)
        ])
    }
}

// MARK: - View Constants

private extension CGFloat {
    static let padding: CGFloat = 67.5
    static let spacing: CGFloat = 27
    static let topPadding: CGFloat = 19
    static let pinDotViewHeight: CGFloat = 40
    static let forgotPINAlpha: CGFloat = 0.5
}
