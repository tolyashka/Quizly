//
//  SelectedQuestionConfiguration.swift
//  Quizly
//
//  Created by Анатолий Лушников on 10.08.2025.
//

protocol SelectableConfigurator: AnyObject {
    var itemValues: [QuestionItemViewModel] { get }
    
    func updateValue(_ item: QuestionItemViewModel, for section: QuestionSection) -> QuestionItemViewModel?
    func removeValue(for key: QuestionSection)
    func getTitleItems() -> String
}

final class ConfigurationSelector: SelectableConfigurator {
    private typealias QuestionConfiguration = [QuestionSection: QuestionItemViewModel]
    
    var itemValues: [QuestionItemViewModel] {
        Array(selectedConfiguration.values)
    }
    
    private var selectedConfiguration: QuestionConfiguration = [:] {
        didSet { saveConfiguration(); }
    }
    
    private let configurationStorage: IConfigurationStorage
    
    init(configurationStorage: IConfigurationStorage, sections: [QuestionSectionViewModel]) {
        self.configurationStorage = configurationStorage
        self.selectedConfiguration = restore(for: sections) ?? defaults(from: sections)
    }
    
    func updateValue(_ item: QuestionItemViewModel, for section: QuestionSection) -> QuestionItemViewModel? {
        selectedConfiguration.updateValue(item, forKey: section)
    }
    
    func removeValue(for section: QuestionSection) {
        selectedConfiguration.removeValue(forKey: section)
    }
    
    func getTitleItems() -> String {
        var resultTitle = String()
        
        for value in selectedConfiguration.values {
            resultTitle += value.title + "\n"
        }
        
        return resultTitle
    }
    
    private func restore(for sections: [QuestionSectionViewModel]) -> QuestionConfiguration? {
        guard let savedConfiguration = configurationStorage.get(
            type: [QuestionItemViewModel].self,
            forKey: .selectedItems),
            !savedConfiguration.isEmpty
        else {
            return nil
        }
        
        return Dictionary(uniqueKeysWithValues:
            sections.enumerated().map { index, section in
                (section.type, savedConfiguration[index])
            }
        )
    }
    
    private func defaults(from sections: [QuestionSectionViewModel]) -> QuestionConfiguration {
        Dictionary(uniqueKeysWithValues: sections.compactMap { section in
            section.selectedItem.map { (section.type, $0) }
        })
    }
    
    private func saveConfiguration() {
        configurationStorage.save(storedValue: Array(selectedConfiguration.values), for: .selectedItems)
    }
}


protocol SavableConfigurator {
    var currentSavedConfiguration: [QuestionItemViewModel]? { get }
    
    func save(_ value: [QuestionItemViewModel], for key: StorageIdentifier)
}

final class ConfiguratorSaver: SavableConfigurator {
    private let configurationStorage: IConfigurationStorage
    
    var currentSavedConfiguration: [QuestionItemViewModel]? {
        let model = configurationStorage.get(type: [QuestionItemViewModel].self, forKey: .selectedItems)
        return model?.sorted {
            $0.queryItem == $1.queryItem
        }
    }
    
    init(configurationStorage: IConfigurationStorage) {
        self.configurationStorage = configurationStorage
    }
    
    func save(_ value: [QuestionItemViewModel], for key: StorageIdentifier) {
        configurationStorage.save(storedValue: value, for: key)
    }
}
