//
//  QuestionConfiguratorViewController.swift
//  Quizly
//
//  Created by Анатолий Лушников on 21.05.2025.
//

import UIKit

class QuestionConfiguratorViewController: UIViewController, IQuestionConfiguratorView {
    private let presenter: IQuestionConfiguratorPresenter
    
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
    
    private func configureView() {
        setLayoutConstraints()
        configureDataSource()
        applySnapshot()
    }
    
    private func setLayoutConstraints() {
        view.addSubview(questionCollectionView)
        NSLayoutConstraint.activate([
            questionCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            questionCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            questionCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            questionCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
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
        presenter.applySnapshot()
    }
}
