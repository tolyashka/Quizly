//
//  CategoryView.swift
//  Quizly
//
//  Created by Анатолий Лушников on 12.05.2025.
//

import UIKit

final class CategoryView: UIView {
    private var presenter: IMenuPresenter?
    // FIXME: Поменять тексты на константы 
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Текущая категория:"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()

    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "20 случайных вопросов"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .darkGray
        return label
    }()

    private let arrowImageView: UIImageView = {
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .medium)
        let image = UIImage(systemName: "chevron.right", withConfiguration: config)
        let imageView = UIImageView(image: image)
        imageView.tintColor = .darkGray
        imageView.contentMode = .center
        imageView.backgroundColor = UIColor.systemGray6
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()

    func configure(category: String) {
        categoryLabel.text = category
    }

    // MARK: - Init

    init(presenter: IMenuPresenter) {
        self.presenter = presenter
        super.init(frame: .zero)
        setupView()
        setupTap()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Setup View
    override func layoutSubviews() {
        super.layoutSubviews()
        setDefaultShadow()
    }
    
    private func setupView() {
        self.layer.cornerRadius = 15
        backgroundColor = .white
        
        let labelsStack = UIStackView(arrangedSubviews: [titleLabel, categoryLabel])
        labelsStack.axis = .vertical
        labelsStack.spacing = 4

        let mainStack = UIStackView(arrangedSubviews: [labelsStack, arrowImageView])
        mainStack.axis = .horizontal
        mainStack.spacing = 12
        mainStack.alignment = .center
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(mainStack)

        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            arrowImageView.widthAnchor.constraint(equalToConstant: 32),
            arrowImageView.heightAnchor.constraint(equalToConstant: 32)
        ])
    }

    // MARK: - Gesture

    private func setupTap() {
        isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }

    @objc private func handleTap() {
        presenter?.chooseCategory()
    }
}
