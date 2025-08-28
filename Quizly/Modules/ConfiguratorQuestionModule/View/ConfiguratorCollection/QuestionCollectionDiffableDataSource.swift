//
//  QuestionCollectionDiffableDataSource.swift
//  Quizly
//
//  Created by Анатолий Лушников on 13.08.2025.
//

import UIKit

final class QuestionConfiguratorDataSource<Cell: UICollectionViewCell>: UICollectionViewDiffableDataSource<QuestionSection, QuestionItemViewModel> {
    
    init(collectionView: UICollectionView, cellCompletion: @escaping (Cell, IndexPath, QuestionItemViewModel) -> Void) {
        super.init(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as? Cell else {
                return UICollectionViewCell()
            }
            cellCompletion(cell, indexPath, itemIdentifier)
            return cell
        }
    }
    
    func apply(sections: [QuestionSectionViewModel], animated animate: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<QuestionSection, QuestionItemViewModel>()
        for section in sections {
            snapshot.appendSections([section.type])
            snapshot.appendItems(section.items, toSection: section.type)
        }
        apply(snapshot, animatingDifferences: animate)
    }
}
