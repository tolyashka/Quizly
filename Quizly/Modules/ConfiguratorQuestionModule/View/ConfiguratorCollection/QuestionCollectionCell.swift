//
//  QuestionCollectionCell.swift
//  Quizly
//
//  Created by Анатолий Лушников on 29.05.2025.
//

import UIKit

final class QuestionConfigCollectionViewCell: UICollectionViewCell {    
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
    
    func setSelectedAppearance(_ isSelected: Bool) {
        configureColor(with: isSelected)
    }
    
    func setValues(model: QuestionItemViewModel) {
        self.titleLabel.text = model.title
    }
}

// MARK: - Configure views
private extension QuestionConfigCollectionViewCell {
    func configureColor(with flag: Bool) {
        let selectedColor = UIColor.systemYellow
        let defaultColor = UIColor.clear
        
        contentView.backgroundColor = flag ? selectedColor : defaultColor
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
