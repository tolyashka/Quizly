//
//  QuestionConfiguratorPresenter.swift
//  Quizly
//
//  Created by Анатолий Лушников on 29.05.2025.
//

import UIKit

final class QuestionConfiguratorPresenter {
    typealias SectionItemConfiguration = [QuestionSection: QuestionItemViewModel]
    
    private var dataSource: UICollectionViewDiffableDataSource<QuestionSection, QuestionItemViewModel>?
    private let coordinator: Coordinator
    private var view: IQuestionConfiguratorView?
    private let model: IQuestionSectionFactory
    private let configuratorStorage: IConfigurationStorage
    private var selectedItems: SectionItemConfiguration = [:]
    private lazy var sections = model.makeSections()
    
    init(coordinator: Coordinator, model: IQuestionSectionFactory, configuratorStorage: IConfigurationStorage) {
        self.coordinator = coordinator
        self.model = model
        self.configuratorStorage = configuratorStorage
        updateSelectedItems()
    }
}

extension QuestionConfiguratorPresenter: IQuestionConfiguratorPresenter {
    func viewDidLoaded(_ view: IQuestionConfiguratorView) {
        self.view = view
    }
    
    func popViewController() {
        let coordinator = coordinator as? ConfigurationQuestionCoordinator
        coordinator?.dismiss()
    }

    func getCurrentConfiguration() -> SectionItemConfiguration {
        return selectedItems
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
        guard let selectedSections = getSelectedConfiguration(
            for: .selectedItems,
            with: SectionItemConfiguration.self
        ) else {
            applyDefaultSnapshot()
            return
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<QuestionSection, QuestionItemViewModel>()
        for section in sections {
                let updatedItems = section.items.map { item in
                    if let selected = selectedSections[section.type],
                       selected.title == item.title {
                        return QuestionItemViewModel(id: item.id, title: item.title, isSelected: true, queryItem: item.queryItem)
                    } else {
                        return QuestionItemViewModel(id: item.id, title: item.title, isSelected: false, queryItem: item.queryItem)
                    }
                }
                snapshot.appendSections([section.type])
                snapshot.appendItems(updatedItems, toSection: section.type)
            }
            
            dataSource?.apply(snapshot, animatingDifferences: true)
        }
    
    private func applyDefaultSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<QuestionSection, QuestionItemViewModel>()
        
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
    
    // MARK: - Set/get question configurator in storage
    func updateStorage(for key: StorageIdentifier) {
        configuratorStorage.save(storedValue: selectedItems, for: key)
    }
    
    func getSelectedConfiguration(for key: StorageIdentifier, with type: SectionItemConfiguration.Type) -> SectionItemConfiguration? {
        configuratorStorage.get(type: type, forKey: key)
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
                isSelected: item == selected,
                queryItem: item.queryItem
            )
        }
        
        snapshot.deleteItems(oldItems)
        snapshot.appendItems(newItems, toSection: section)
        
        dataSource?.apply(snapshot, animatingDifferences: true)
        setSelectItem(selected, in: section)
    }
    
    func updateSelectedItems() {
//        let selectedItems = sections.map { $0.items.filter { $0.isSelected }
        let selectedItems = sections.flatMap { section in
            let selectedItems = section.items.filter { $0.isSelected }
            return (section, selectedItems)
        }
        
        for (section, selectedItems) in selectedItems {
            for selectedItem in selectedItems {
                setSelectItem(selectedItem, in: section.type)
            }
        }
    }
}
