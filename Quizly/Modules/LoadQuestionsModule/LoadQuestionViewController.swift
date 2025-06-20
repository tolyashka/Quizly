//
//  LoadQuestionViewController.swift
//  Quizly
//
//  Created by Анатолий Лушников on 13.06.2025.
//

import UIKit

protocol ILoadQuestionView: AnyObject {
    func updateLoad(with isLoaded: Bool)
    func loadWithError(titleError: String)
}

final class LoadQuestionViewController: UIViewController, ILoadQuestionView {
    private let loadLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 32)
        label.numberOfLines = 3
        label.text = "Загружаем вопросы..."
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let loadIndicator: UIActivityIndicatorView = {
        let loadIndicator = UIActivityIndicatorView(style: .large)
        loadIndicator.color = .systemYellow
        loadIndicator.hidesWhenStopped = true
        loadIndicator.translatesAutoresizingMaskIntoConstraints = false
        return loadIndicator
    }()
    
    private let loadErrorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "NetworkErrorImage")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Вернуться в главное меню", for: .normal)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 15
        button.isHidden = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let presenter: ILoadQuestionPresenter
    
    init(presenter: ILoadQuestionPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("LoadQuestionViewController deinit")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoaded(self)
        configureViews()
    }
    
    func updateLoad(with isLoaded: Bool) {
        updateLoadIndicator(with: isLoaded)
        backButton.isHidden = true
        self.loadErrorImageView.isHidden = true
    }
    
    func loadWithError(titleError: String) {
        self.loadLabel.text = titleError
        self.loadErrorImageView.isHidden = false
        self.backButton.isHidden = false
    }
    
    @objc private func backButtonAction() {
        presenter.popWithError()
    }
    
    private func updateLoadIndicator(with isAnimating: Bool) {
        isAnimating ? loadIndicator.startAnimating() : loadIndicator.stopAnimating()
    }
}

extension LoadQuestionViewController {
    func configureViews() {
        view.addSubview(loadLabel)
        view.addSubview(loadIndicator)
        view.addSubview(backButton)
        view.addSubview(loadErrorImageView)
        configureLayoutConstraints()
    }
    
    func configureLayoutConstraints() {
        NSLayoutConstraint.activate([
            loadLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            loadLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            loadLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            loadIndicator.topAnchor.constraint(equalTo: loadLabel.bottomAnchor, constant: 25),
            loadIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loadErrorImageView.topAnchor.constraint(equalTo: loadLabel.bottomAnchor, constant: 25),
            loadErrorImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            loadErrorImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            loadErrorImageView.heightAnchor.constraint(equalToConstant: 300),
            
            backButton.topAnchor.constraint(equalTo: loadErrorImageView.bottomAnchor, constant: 35),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            backButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}

