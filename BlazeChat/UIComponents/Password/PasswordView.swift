//
//  PasswordView.swift
//  BlazeChat
//
//  Created by Stefano on 17.01.21.
//

import UIKit

open class PasswordView: UIControl {
    
    public enum State {
        case input(length: Int)
        case error(message: String, inputLength: Int)
    }

    private let pinStackView = UIStackView()
    private let errorLabel = UILabel()
    private let dotCodeViews: [DotView]

    private let maxLength: Int

    public init(frame: CGRect = .zero, maxLength: Int = 8) {
        self.maxLength = maxLength
        dotCodeViews = (0..<maxLength).map { _ in DotView() }
        super.init(frame: frame)
        setupViews()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func set(state: State) {
        switch state {
        case .input(length: let inputLength):
            setInput(withInputLength: inputLength)
        case .error(message: let message, inputLength: let inputLength):
            setErrorWith(message: message, inputLength: inputLength)
        }
    }
}

// MARK: - State Changes

private extension PasswordView {
    
    func setInput(withInputLength inputLength: Int) {
        update(pinLength: inputLength)
        errorLabel.isHidden = true
    }
    
    func setErrorWith(message: String, inputLength: Int) {
        update(pinLength: inputLength)
        dotCodeViews[0..<inputLength].forEach({ $0.set(state: .error) })
        errorLabel.text = message
        errorLabel.isHidden = false
    }
}

// MARK: - View Setup

private extension PasswordView {
    
    func setupViews() {
        setupPinStackView()
        setupErrorLabel()
    }

    func setupPinStackView() {
        pinStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(pinStackView)
        dotCodeViews.forEach(pinStackView.addArrangedSubview)
        NSLayoutConstraint.activate([
            pinStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pinStackView.topAnchor.constraint(equalTo: topAnchor),
            pinStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pinStackView.heightAnchor.constraint(equalToConstant: .height)
        ])
        pinStackView.spacing = .stackViewSpacing
    }
    
    func setupErrorLabel() {
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(errorLabel)
        NSLayoutConstraint.activate([
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorLabel.topAnchor.constraint(equalTo: pinStackView.bottomAnchor, constant: .spacing),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            errorLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        errorLabel.textAlignment = .center
        errorLabel.font = Theme.font.body2
        errorLabel.textColor = Theme.color.error
        errorLabel.isHidden = true
    }
    
    func update(pinLength: Int) {
        guard pinLength <= maxLength else { return assertionFailure("Max PIN input exceeded.") }
        dotCodeViews.forEach({ $0.set(state: .unselected) })
        dotCodeViews[0..<pinLength].forEach({ $0.set(state: .highlighted) })
    }
}

// MARK: - View Constants

private extension CGFloat {
    static let spacing: CGFloat = 10
    static let stackViewSpacing: CGFloat = 20
    static let height: CGFloat = 14
}
