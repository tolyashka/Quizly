//
//  QuestionConfiguratorViewController.swift
//  Quizly
//
//  Created by Анатолий Лушников on 21.05.2025.
//

import UIKit

final class QuestionConfiguratorViewController: UIViewController {
    private let presenter: IQuestionConfiguratorPresenter

    private lazy var saveConfigurationButton: UIButton = {
        let button = UIButton()
        button.setTitle(ConfigurationConstants.ViewConstant.saveConfiguration.rawValue, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.withAlphaComponent(0.5).cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(
            self,
            action: #selector(saveConfiguration),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var selectedConfigurationLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var questionCollectionView: QuestionConfigCollectionView = {
        let collectionView = QuestionConfigCollectionView(frame: .zero)
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    init(presenter: IQuestionConfiguratorPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        print("deinit QuestionConfiguratorViewController")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoaded(self)
        configureView()
    }
    
    @objc private func saveConfiguration() {
        presenter.saveConfiguration()
        presenter.popViewController()
    }
}

extension QuestionConfiguratorViewController: IQuestionConfiguratorView {
    func updateCurrentConfiguration(with title: String) {
        selectedConfigurationLabel.text = title
    }
}

extension QuestionConfiguratorViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItemAt(collectionView: collectionView, indexPath: indexPath)
    }
}

private extension QuestionConfiguratorViewController {
    func configureDataSource() {
        presenter.configureDataSource(for: questionCollectionView)
    }
    
    func applySnapshot() {
        presenter.applySnapshot(withAnimation: false)
    }
}

private extension QuestionConfiguratorViewController {
    func configureView() {
        setLayoutConstraints()
        configureDataSource()
        applySnapshot()
    }
    
    func setLayoutConstraints() {
        view.addSubview(questionCollectionView)
        view.addSubview(saveConfigurationButton)
        view.addSubview(selectedConfigurationLabel)
        
        NSLayoutConstraint.activate([
            selectedConfigurationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            selectedConfigurationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            selectedConfigurationLabel.trailingAnchor.constraint(equalTo: saveConfigurationButton.leadingAnchor, constant: -5),
            selectedConfigurationLabel.heightAnchor.constraint(equalToConstant: 90),
            
            saveConfigurationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            saveConfigurationButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            saveConfigurationButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            saveConfigurationButton.heightAnchor.constraint(equalToConstant: 50),
            
            questionCollectionView.topAnchor.constraint(equalTo: selectedConfigurationLabel.bottomAnchor, constant: 10),
            questionCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            questionCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            questionCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
