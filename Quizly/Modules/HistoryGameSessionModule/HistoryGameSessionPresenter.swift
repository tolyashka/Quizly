//
//  HistoryGameSessionPresenter.swift
//  Quizly
//
//  Created by Анатолий Лушников on 20.06.2025.
//

import UIKit

protocol IHistoryGameSessionPresenter: AnyObject {
    var heightForRow: CGFloat { get }
    
    func viewDidLoaded(_ view: IHistoryGameSessionView)
    func updateHistory(with gameSessions: [GameSession])
    func configureDataSource(for tableView: UITableView)
}

final class HistoryGameSessionPresenter {
    private var diffableDataSource: HistoryListDataSource<HistoryTableViewCell>?
    private let dataService: IDataService
    private weak var view: IHistoryGameSessionView?
    private weak var coordinator: Coordinator?

    init(coordinator: Coordinator, dataService: IDataService) {
        self.coordinator = coordinator
        self.dataService = dataService
    }
}

extension HistoryGameSessionPresenter {
    var gameSessionsResults: [QuizResultModel]? {
        let fetchedResults = dataService.fetchResults()
        print(fetchedResults)
        var result: [QuizResultModel]?
        switch fetchedResults {
        case .success(let success):
            result = success
        case .failure(_):
            result = nil
        }
        return result
    }
    
    func updateHistory(with gameSessions: [GameSession]) {
//        view?.updateTableView()
    }
}

extension HistoryGameSessionPresenter: IHistoryGameSessionPresenter {
    var heightForRow: CGFloat {
        return 85.0
    }
    
    func configureDataSource(for tableView: UITableView) {
        diffableDataSource = HistoryListDataSource(
            tableView: tableView) { cell, indexPath, model in
                cell.updateValue(with: model)
        }
    }
    
    func applySnapshot() {
        guard let gameSessionsResults else { return }
        diffableDataSource?.apply(with: gameSessionsResults)
    }
    
    func viewDidLoaded(_ view: any IHistoryGameSessionView) {
        self.view = view
        applySnapshot()
    }
}
