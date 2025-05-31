//
//  QuestionConfiguratorPresenter.swift
//  Quizly
//
//  Created by Анатолий Лушников on 29.05.2025.
//

import UIKit

class QuestionConfiguratorPresenter {
    private var dataSource: UICollectionViewDiffableDataSource<QuestionSection, QuestionItemViewModel>?
    private let coordinator: Coordinator
    private var view: IQuestionConfiguratorView?
    private let model: IQuestionSectionFactory
    private var selectedItems: [QuestionSection: QuestionItemViewModel] = [:]
    
    init(coordinator: Coordinator, model: IQuestionSectionFactory) {
        self.coordinator = coordinator
        self.model = model
    }
}

extension QuestionConfiguratorPresenter: IQuestionConfiguratorPresenter {
    func viewDidLoaded(_ view: IQuestionConfiguratorView) {
        self.view = view
    }
    
    func configureDataSource(for collectionView: UICollectionView) {
        dataSource = UICollectionViewDiffableDataSource<QuestionSection, QuestionItemViewModel>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: QuestionConfigCollectionViewCell.identifier,
                    for: indexPath) as? QuestionConfigCollectionViewCell else { return UICollectionViewCell() }
                
                cell.setValues(model: itemIdentifier)
                return cell
            }
        )
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<QuestionSection, QuestionItemViewModel>()
        let sections = model.makeSections()
        
        for section in sections {
            snapshot.appendSections([section.type])
            snapshot.appendItems(section.items, toSection: section.type)
        }
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    func didSelectItemAt(collectionView: UICollectionView, indexPath: IndexPath) {
        guard let section = dataSource?.snapshot().sectionIdentifiers[indexPath.section],
              let selectedItem = dataSource?.itemIdentifier(for: indexPath)
        else { return }
        
        if isSelected(selectedItem, in: section) { return }
        updateSelection(for: section, selected: selectedItem)
    }
}

private extension QuestionConfiguratorPresenter {
    func setSelectItem(_ item: QuestionItemViewModel, in section: QuestionSection) {
        selectedItems[section] = item
    }
    
    func isSelected(_ item: QuestionItemViewModel, in section: QuestionSection) -> Bool {
        return selectedItems[section] == item
    }
    
    func updateSelection(for section: QuestionSection, selected: QuestionItemViewModel) {
        guard var snapshot = dataSource?.snapshot() else { return }
        
        let oldItems = snapshot.itemIdentifiers(inSection: section)
        let newItems = oldItems.map { item in
            QuestionItemViewModel(
                id: item.id,
                title: item.title,
                isSelected: item == selected
            )
        }
        
        snapshot.deleteItems(oldItems)
        snapshot.appendItems(newItems, toSection: section)
        
        dataSource?.apply(snapshot, animatingDifferences: true)
        setSelectItem(selected, in: section)
    }
}
