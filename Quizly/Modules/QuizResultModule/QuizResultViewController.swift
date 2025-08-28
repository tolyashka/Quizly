//
//  QuizResultViewController.swift
//  Quizly
//
//  Created by Анатолий Лушников on 02.06.2025.
//

import UIKit

protocol IQuizResultView: AnyObject {
    func showScoreText(_ text: String)
}

final class QuizResultViewController: UIViewController {
    private let presenter: IQuizResultPresenter

    private let resultLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(QuizResultConstants.QuizResulViewtConstants.back.rawValue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = .systemYellow
        button.tintColor = .black
        button.layer.cornerRadius = 15
        return button
    }()

    init(presenter: IQuizResultPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        print("deinit QuizResultViewController")
    }
    
    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        presenter.viewDidLoad(self)
    }

    private func setupLayout() {
        view.addSubview(resultLabel)
        view.addSubview(backButton)

        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            backButton.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 30),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 200),
            backButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
    }

    @objc private func backTapped() {
        presenter.didTapBack()
    }
}

extension QuizResultViewController: IQuizResultView {
    func showScoreText(_ text: String) {
        resultLabel.text = text
    }
}
