//
//  CategoryView.swift
//  Quizly
//
//  Created by Анатолий Лушников on 12.05.2025.
//

import UIKit
protocol ICategoryView: AnyObject {
    var delegate: CategoryViewDelegate? { get }
    
    func configure(category: [QuestionSection: QuestionItemViewModel]?)
}

final class CategoryView: UIView {
    weak var delegate: CategoryViewDelegate?
    
    private let imageDimensions = CGFloat(32.0)
    
    private lazy var labelsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = QuizMenuConstants.CategoryConstants.titleCategory.rawValue
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .medium)
        let image = UIImage(
            systemName: QuizMenuConstants.CategoryConstants.nextPresenrationImage.rawValue,
            withConfiguration: config
        )
        let imageView = UIImageView(image: image)
        imageView.tintColor = .darkGray
        imageView.contentMode = .center
        imageView.backgroundColor = UIColor.systemGray6
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        setupView()
        setupTap()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setup Views
    override func layoutSubviews() {
        super.layoutSubviews()
        setDefaultShadow()
    }
    
    // MARK: - Gesture
    
    private func setupTap() {
        isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap() {
        delegate?.categoryViewDidTap(self)
    }
}

// MARK: - ICategoryView protocol implementation
extension CategoryView: ICategoryView {
    func configure(category categories: [QuestionSection: QuestionItemViewModel]?) {
        guard let categories else {
            categoryLabel.text = QuizMenuConstants.CategoryConstants.defaultCategory.rawValue
            return
        }
        
        var categoryTitle = String()
        
        for item in categories.values {
            categoryTitle += item.title + "\n"
        }

        categoryLabel.text = categoryTitle
    }
}

// MARK: - Configure views
private extension CategoryView {
    private func setupView() {
        self.layer.cornerRadius = 15
        backgroundColor = .white
        
        labelsStack.addArrangedSubview(titleLabel)
        labelsStack.addArrangedSubview(categoryLabel)
        
        mainStack.addArrangedSubview(labelsStack)
        mainStack.addArrangedSubview(arrowImageView)
        
        addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            arrowImageView.widthAnchor.constraint(equalToConstant: imageDimensions),
            arrowImageView.heightAnchor.constraint(equalToConstant: imageDimensions)
        ])
    }
}
