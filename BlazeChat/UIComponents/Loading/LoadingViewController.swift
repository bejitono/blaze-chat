//
//  LoadingView.swift
//  BlazeChat
//
//  Created by Stefano on 16.01.21.
//

import UIKit

final class LoadingViewController: UIViewController {
    
    struct Configuration {
        public let title: String
        
        public init(title: String) {
            self.title = title
        }
    }
    
    private let titleLabel = UILabel()
    private let progressIndicatorView = LoadingAnimationView()
    private let overlayView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        progressIndicatorView.start()
    }
    
    func configure(with configuration: Configuration) {
        titleLabel.text = configuration.title
    }
}

// MARK: - View Setup

private extension LoadingViewController {
    
    func setupViews() {
        modalTransitionStyle = .crossDissolve
//        view.backgroundColor = Theme.color.neutral100.withAlphaComponent(.backgroundAlpha)
        setupOverlayView()
        setupTitleLabel()
        setupProgressIndicatorView()
    }
    
    func setupOverlayView() {
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(overlayView)
        NSLayoutConstraint.activate([
            overlayView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            overlayView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            overlayView.widthAnchor.constraint(equalToConstant: .overlayWidth),
            overlayView.heightAnchor.constraint(equalToConstant: .overlayHeight)
        ])
//        overlayView.backgroundColor = Theme.color.primaryBackground
        overlayView.layer.cornerRadius = .overlayCornerRadius
        overlayView.applyShadow()
    }
    
    func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        overlayView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor, constant: .padding),
            titleLabel.topAnchor.constraint(equalTo: overlayView.topAnchor, constant: .padding),
            titleLabel.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: -.padding)
        ])
//        titleLabel.font = Theme.font.body1
        titleLabel.textAlignment = .center
    }
    
    func setupProgressIndicatorView() {
//        overlayView.backgroundColor = Theme.color.primaryBackground
        progressIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.addSubview(progressIndicatorView)
        NSLayoutConstraint.activate([
            progressIndicatorView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .spacing),
            progressIndicatorView.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
            progressIndicatorView.widthAnchor.constraint(equalToConstant: .progressIndicatorHeight),
            progressIndicatorView.heightAnchor.constraint(equalToConstant: .progressIndicatorHeight)
        ])
    }
}

// MARK: - View Constants

private extension CGFloat {
    static let padding: CGFloat = 40
    static let spacing: CGFloat = 20
    static let backgroundAlpha: CGFloat = 0.7
    static let progressIndicatorHeight: CGFloat = 70
    static let overlayHeight: CGFloat = 185
    static let overlayWidth: CGFloat = 200
    static let overlayCornerRadius: CGFloat = 10
}
