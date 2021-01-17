//
//  SeedViewController.swift
//  BlazeChat
//
//  Created by Stefano on 16.01.21.
//

import LightningKitUI
import UIKit

final class SeedViewController: UIViewController {
    
    private let seedView = LightningKitUI.SeedViewController()
    private let loadingView = LoadingViewController()
    private let viewModel: SeedViewModelInput
    
    init(viewModel: SeedViewModelInput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingView()
        viewModel.generateSeed()
    }
}

// MARK: - SeedViewModelOutput

extension SeedViewController: SeedViewModelOutput {
    
    func didGenerate(seed: [String]) {
        setupSeedView(with: seed)
    }
}

// MARK: - SeedViewControllerDelegate

extension SeedViewController: SeedViewControllerDelegate {
    
    func didTapDone() {
        viewModel.confirmSeed()
    }
}

// MARK: - View Setup

private extension SeedViewController {
    
    func setupLoadingView() {
        view.backgroundColor = Theme.color.primaryBackground
        loadingView.modalPresentationStyle = .fullScreen
        navigationController?.present(loadingView, animated: true)
    }
    
    func setupSeedView(with seed: [String]) {
        seedView.delegate = self
        seedView.set(seed: seed)
        seedView.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(seedView.view)
        NSLayoutConstraint.activate([
            seedView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            seedView.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            seedView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            seedView.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        loadingView.dismiss(animated: true)
    }
}
