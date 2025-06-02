//
//  QuestionConfiguratorViewController.swift
//  Quizly
//
//  Created by Анатолий Лушников on 21.05.2025.
//

import UIKit

class QuestionConfiguratorViewController: UIViewController {
    private let presenter: IQuestionConfiguratorPresenter
    
    private lazy var saveConfigurationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoaded(self)
        configureView()
    }
    
    @objc private func saveConfiguration() {
        presenter.updateStorage(for: .selectedItems)
        presenter.popViewController()
    }
}
extension QuestionConfiguratorViewController: IQuestionConfiguratorView {

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
        presenter.applySnapshot()
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
        
        NSLayoutConstraint.activate([
            saveConfigurationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            saveConfigurationButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            saveConfigurationButton.heightAnchor.constraint(equalToConstant: 50),
            saveConfigurationButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            
            questionCollectionView.topAnchor.constraint(equalTo: saveConfigurationButton.bottomAnchor, constant: 10),
            questionCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            questionCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            questionCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
