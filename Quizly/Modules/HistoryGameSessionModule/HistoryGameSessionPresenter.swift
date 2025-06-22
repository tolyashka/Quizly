//
//  HistoryGameSessionPresenter.swift
//  Quizly
//
//  Created by Анатолий Лушников on 20.06.2025.
//

import UIKit

protocol IHistoryGameSessionPresenter {
    var numberOfRows: Int { get }
    var heightForRow: CGFloat { get }
    
    func viewDidLoaded(_ view: IHistoryGameSessionView)
    func updateHistory(with gameSessions: [GameSession])
    func cellForRow(_ tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
}

final class HistoryGameSessionPresenter {
    private let dataService: IDataService
    private weak var view: IHistoryGameSessionView?
    private weak var coordinator: Coordinator?

    init(coordinator: Coordinator, dataService: IDataService) {
        self.coordinator = coordinator
        self.dataService = dataService
    }
}

extension HistoryGameSessionPresenter {
    var gameSessionsResults: [GameSession] {
        dataService.fetchAllGameSessions()
    }
    
    func updateHistory(with gameSessions: [GameSession]) {
        view?.updateTableView()
    }
}
extension HistoryGameSessionPresenter: IHistoryGameSessionPresenter {
    var heightForRow: CGFloat {
        return 125.0
    }
    
    var numberOfRows: Int {
        return gameSessionsResults.count
    }
    
    func viewDidLoaded(_ view: any IHistoryGameSessionView) {
        self.view = view
    }
    
    func cellForRow(_ tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier, for: indexPath) as? HistoryTableViewCell else { return UITableViewCell() }
        cell.updateValue(with: gameSessionsResults[indexPath.row])
        return cell
    }
}
