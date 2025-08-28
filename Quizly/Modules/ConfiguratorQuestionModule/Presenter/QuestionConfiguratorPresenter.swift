//
//  QuestionConfiguratorPresenter.swift
//  Quizly
//
//  Created by Анатолий Лушников on 29.05.2025.
//

import UIKit

final class QuestionConfiguratorPresenter {
    private var diffableDataSource: QuestionConfiguratorDataSource<QuestionConfigCollectionViewCell>?
    
    private var coordinator: Coordinator?
    private weak var view: IQuestionConfiguratorView?
    private let model: [QuestionSectionViewModel]
    private var configurationSelector: SelectableConfigurator
    private let savableConfigurator: SavableConfigurator
    private let configurationNotificationCenter: QuestionConfigurationEvent
    
    init(coordinator: Coordinator,
         model: [QuestionSectionViewModel],
         configurationSelector: SelectableConfigurator,
         savableConfigurator: SavableConfigurator,
         configurationNotificationCenter: QuestionConfigurationEvent) {
        self.coordinator = coordinator
        self.model = model
        self.configurationSelector = configurationSelector
        self.savableConfigurator = savableConfigurator
        self.configurationNotificationCenter = configurationNotificationCenter
    }
}

extension QuestionConfiguratorPresenter: IQuestionConfiguratorPresenter {
    func viewDidLoaded(_ view: IQuestionConfiguratorView) {
        self.view = view
        self.view?.updateCurrentConfiguration(with: configurationSelector.getTitleItems())
    }
    
    func popViewController() {
        let coordinator = coordinator as? ConfigurationQuestionCoordinator
        coordinator?.dismiss()
    }
    
    func saveConfiguration() {
        savableConfigurator.save(configurationSelector.itemValues, for: .selectedItems)
        
        if let currentSavedConfiguration = savableConfigurator.currentSavedConfiguration {
            configurationNotificationCenter.post(.userDidSelectItem, value: currentSavedConfiguration)
        }
    }
    
    func configureDataSource(for collectionView: UICollectionView) {
        diffableDataSource = QuestionConfiguratorDataSource(
            collectionView: collectionView,
            cellCompletion: { cell, _, itemViewModel in
                cell.setValues(model: itemViewModel)
                cell.setSelectedAppearance(itemViewModel.isSelected)
            }
        )
    }
    
    func applySnapshot(withAnimation animated: Bool = true) {
        diffableDataSource?.apply(sections: model, animated: true)
    }
    
    func didSelectItemAt(collectionView: UICollectionView, indexPath: IndexPath) {
        let currentSection = model[indexPath.section]
        let items = currentSection.items
        let currentItem = items[indexPath.row]
    
        for item in items where item.isSelected {
            item.isSelected = false
        }
        currentItem.isSelected = true

        configurationSelector.updateValue(currentItem, for: currentSection.type)

        var snapshot = diffableDataSource?.snapshot()
        snapshot?.reloadItems(items)
        if let snapshot { diffableDataSource?.apply(snapshot, animatingDifferences: true) }

        view?.updateCurrentConfiguration(with: configurationSelector.getTitleItems())
    }

}
