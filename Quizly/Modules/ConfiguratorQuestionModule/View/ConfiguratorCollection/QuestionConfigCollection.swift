//
//  QuestionConfigCollection.swift
//  Quizly
//
//  Created by Анатолий Лушников on 29.05.2025.
//

import UIKit

final class QuestionConfigCollectionView: UICollectionView {
    private var compositionalLayout: UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout(section: configureQuestionCategory())
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        self.collectionViewLayout = compositionalLayout
        self.register(QuestionConfigCollectionViewCell.self, forCellWithReuseIdentifier: QuestionConfigCollectionViewCell.identifier)
    }
    
    func configureQuestionCategory() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(50), 
            heightDimension: .estimated(40)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(1000)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        section.interGroupSpacing = 12

        return section
    }
}

