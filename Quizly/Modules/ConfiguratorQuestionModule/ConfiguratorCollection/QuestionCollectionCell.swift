//
//  QuestionCollectionCell.swift
//  Quizly
//
//  Created by Анатолий Лушников on 29.05.2025.
//

import UIKit

final class QuestionConfigCollectionViewCell: UICollectionViewCell {
    static var identifier: String {
        String(describing: QuestionConfigCollectionViewCell.self)
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        setLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setValues(model: QuestionItemViewModel) {
        self.titleLabel.text = model.title
        configureColor(with: model)
    }
}

// MARK: - Configure views
private extension QuestionConfigCollectionViewCell {
    func configureColor(with model: QuestionItemViewModel) {
        let selectedColor = UIColor.systemYellow.withAlphaComponent(0.25)
        let defaultColor = UIColor.white
        
        contentView.backgroundColor = model.isSelected ? selectedColor : defaultColor
    }
    
    func configureCell() {
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func setLayoutConstraints() {
        self.contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
