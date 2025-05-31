//
//  IQuestionConfiguratorPresenter.swift
//  Quizly
//
//  Created by Анатолий Лушников on 29.05.2025.
//

import UIKit

protocol IQuestionConfiguratorPresenter: AnyObject {
    func viewDidLoaded(_ view: IQuestionConfiguratorView)
    func configureDataSource(for collectionView: UICollectionView)
    func didSelectItemAt(collectionView: UICollectionView, indexPath: IndexPath)
    func applySnapshot()
}
