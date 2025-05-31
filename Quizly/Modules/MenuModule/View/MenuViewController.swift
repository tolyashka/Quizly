//
//  MenuViewController.swift
//  Quizly
//
//  Created by Анатолий Лушников on 11.05.2025.
//

import UIKit

protocol IStartMenuView: AnyObject {
    
}

class MenuViewController: UIViewController {
    private let presenter: IMenuPresenter
    
    private lazy var categoryView: CategoryView = {
        let categoryView = CategoryView(presenter: presenter)
        categoryView.translatesAutoresizingMaskIntoConstraints = false
        return categoryView
    }()
    
    // FIXME: Поменять тексты на константы
    private lazy var titleAppLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemYellow
        label.font = .boldSystemFont(ofSize: 52)
        label.text = "Quizly" // !
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton(configuration: .plain(), primaryAction: nil)
        button.setImage(UIImage(systemName: "gearshape"), for: .normal) // !
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 20
        button.setContentHuggingPriority(.required, for: .horizontal)
        return button
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemYellow
        button.setTitle("Играть", for: .normal) // !!
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.darkGray, for: .normal)
        button.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return button
    }()

    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(presenter: IMenuPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setDefaultShadow()
    }
}

extension MenuViewController: IStartMenuView {
    
}

// MARK: - Configure views
private extension MenuViewController {
    func setDefaultShadow() {
        settingsButton.setDefaultShadow()
        playButton.setDefaultShadow()
        categoryView.setDefaultShadow()
    }
    
    func configureViews() {
        view.addSubview(titleAppLabel)
        view.addSubview(categoryView)
        view.addSubview(buttonsStackView)
        
        buttonsStackView.addArrangedSubview(playButton)
        buttonsStackView.addArrangedSubview(settingsButton)
        
        configureLayoutConstraints()
    }
    
    func configureLayoutConstraints() {
        NSLayoutConstraint.activate([
            titleAppLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 115),
            titleAppLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            titleAppLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            categoryView.topAnchor.constraint(equalTo: titleAppLabel.bottomAnchor, constant: 65),
            categoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            categoryView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            categoryView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            
            buttonsStackView.topAnchor.constraint(equalTo: categoryView.bottomAnchor, constant: 25),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
