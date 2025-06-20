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

extension HistoryGameSessionPresenter: IHistoryGameSessionPresenter {
    var heightForRow: CGFloat {
        return 150.0
    }
    
    var numberOfRows: Int {
        return 3
    }
    
    func viewDidLoaded(_ view: any IHistoryGameSessionView) {
        self.view = view
    }
    
    func cellForRow(_ tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier, for: indexPath) as? HistoryTableViewCell else { return UITableViewCell() }
        // !!!
        return cell
    }
}
