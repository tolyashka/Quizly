//
//  HistoryListDataSource.swift
//  Quizly
//
//  Created by Анатолий Лушников on 27.08.2025.
//

import UIKit

final class HistoryListDataSource<Cell: UITableViewCell>:
    UITableViewDiffableDataSource<HistorySection, QuizResultModel> {
    
    init(
        tableView: UITableView,
        cellCompletion: @escaping (Cell, IndexPath, QuizResultModel) -> Void
    ) {
        super.init(tableView: tableView) { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.identifier, for: indexPath) as? Cell else {
                return UITableViewCell()
            }
            cellCompletion(cell, indexPath, itemIdentifier)
            return cell
        }
    }
    
    func apply(with values: [QuizResultModel], animate: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<HistorySection, QuizResultModel>()
        snapshot.appendSections(HistorySection.allCases)
        snapshot.appendItems(values)
        apply(snapshot, animatingDifferences: animate)
    }
}
