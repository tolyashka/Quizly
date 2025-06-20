//
//  QuizSessionView.swift
//  Quizly
//
//  Created by Анатолий Лушников on 01.06.2025.
//

import UIKit

protocol IQuizSessionView: AnyObject {
    func displayQuestion(_ question: String)
    func showAnswers(_ answers: [String])
    func highlightAnswer(at index: Int, isCorrect: Bool)
    func disableAllAnswers()
    func showProgress(current: Int)
}

final class QuizViewController: UIViewController {
    private let presenter: IQuizSessionPresenter
    private let observerProgress = Progress()
    private var answerButtons: [UIButton] = []
    private let defaultDimensionValue: CGFloat = 20
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var progressStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressTintColor = .systemYellow
        progressView.observedProgress = observerProgress
        progressView.layer.borderColor = UIColor.black.cgColor
        progressView.layer.borderWidth = 0.3
        progressView.layer.cornerRadius = 5
        progressView.clipsToBounds = true
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(presenter: IQuizSessionPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit QuizViewController")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupView()
        presenter.viewDidLoad(self)
    }
    
    @objc private func answerTapped(_ sender: UIButton) {
        presenter.didSelectAnswer(at: sender.tag)
    }
}

// MARK: - IQuizSessionView
extension QuizViewController: IQuizSessionView {
    func displayQuestion(_ question: String) {
        questionLabel.text = question
    }

    func showAnswers(_ answers: [String]) {
        buttonStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        createButton(with: answers)
    }

    func highlightAnswer(at index: Int, isCorrect: Bool) {
        let button = answerButtons[index]
        button.backgroundColor = isCorrect ? .systemGreen : .systemRed
    }

    func disableAllAnswers() {
        answerButtons.forEach { $0.isEnabled = false }
    }

    func showProgress(current: Int) {
        observerProgress.completedUnitCount = Int64(current)
        progressLabel.text = "Вопрос \(current) из \(presenter.getTotalQuestionsCount())"
    }
}

private extension QuizViewController {
    func createButton(with answers: [String]) {
        answerButtons = []
        for (index, answer) in answers.enumerated() {
            let button = UIButton()
            button.setTitle(answer, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = .boldSystemFont(ofSize: 18)
            button.tag = index
            button.backgroundColor = .systemYellow
            button.layer.cornerRadius = 15
            button.addTarget(self, action: #selector(answerTapped), for: .touchUpInside)
            answerButtons.append(button)
            buttonStackView.addArrangedSubview(button)
        }
    }
    func setupView() {
        view.addSubview(progressStackView)
        view.addSubview(buttonStackView)
        view.addSubview(questionLabel)
        
        progressStackView.addArrangedSubview(progressView)
        progressStackView.addArrangedSubview(progressLabel)
        setTotalQuestionsCount()
        
        setLayoutConstraints()
    }
    
    func setLayoutConstraints() {
        NSLayoutConstraint.activate([
            progressStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: defaultDimensionValue),
            progressStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: defaultDimensionValue),
            progressStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -defaultDimensionValue),
            
            questionLabel.topAnchor.constraint(equalTo: progressStackView.bottomAnchor, constant: defaultDimensionValue),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: defaultDimensionValue),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -defaultDimensionValue),
            questionLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35),
            
            buttonStackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: defaultDimensionValue),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: defaultDimensionValue),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -defaultDimensionValue),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -defaultDimensionValue)
        ])
    }
    
    func setTotalQuestionsCount() {
        observerProgress.totalUnitCount = presenter.getTotalQuestionsCount()
    }
}
