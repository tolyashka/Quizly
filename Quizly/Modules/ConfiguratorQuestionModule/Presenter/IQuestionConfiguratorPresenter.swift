//
//  IQuestionConfiguratorPresenter.swift
//  Quizly
//
//  Created by Анатолий Лушников on 29.05.2025.
//

import UIKit

protocol IQuestionConfiguratorPresenter: AnyObject {
    typealias SectionItemConfiguration = [QuestionSection: QuestionItemViewModel]
    func viewDidLoaded(_ view: IQuestionConfiguratorView)
    func configureDataSource(for collectionView: UICollectionView)
    func didSelectItemAt(collectionView: UICollectionView, indexPath: IndexPath)
    func saveConfiguration()
    func applySnapshot(withAnimation animated: Bool)
    func popViewController()
}
