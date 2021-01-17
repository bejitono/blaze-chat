//
//  PasswordDotView.swift
//  BlazeChat
//
//  Created by Stefano on 17.01.21.
//

import UIKit

open class DotView: UIView {
    
    public enum State {
        case unselected
        case highlighted
        case error
    }

    public override var intrinsicContentSize: CGSize {
        CGSize(width: .width, height: super.intrinsicContentSize.height)
    }

    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupViews()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func set(state: State) {
        switch state {
        case .unselected: setUnselected()
        case .highlighted: setHighlighted()
        case .error: setError()
        }
    }
}

// MARK: - State Changes

private extension DotView {

    func setUnselected() {
        layoutBorderWith(borderWidth: .borderWidth, color: Theme.color.neutral300)
        backgroundColor = Theme.color.primaryBackground
    }
    
    func setHighlighted() {
        layoutBorderWith(borderWidth: 0.0, color: Theme.color.neutral300)
        backgroundColor = Theme.color.primary
    }
    
    func setError() {
        layoutBorderWith(borderWidth: 0.0, color: Theme.color.neutral300)
        backgroundColor = Theme.color.error
    }
}

// MARK: - View Setup

private extension DotView {
    
    func setupViews() {
        clipsToBounds = true
        layer.cornerRadius = .cornerRadius
        layoutBorderWith(borderWidth: .borderWidth, color: Theme.color.neutral300)
        backgroundColor = Theme.color.primaryBackground
    }
    
    func layoutBorderWith(borderWidth: CGFloat, color: UIColor) {
        layer.borderWidth = borderWidth
        layer.borderColor = color.cgColor
    }
}

// MARK: - View Constants

private extension CGFloat {
    static let borderWidth: CGFloat = 1
    static let cornerRadius: CGFloat = 7
    static let width: CGFloat = 14
}
