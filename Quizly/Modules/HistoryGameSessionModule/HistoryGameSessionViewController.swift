//
//  HistoryGameSessionViewController.swift
//  Quizly
//
//  Created by Анатолий Лушников on 20.06.2025.
//

import UIKit

protocol IHistoryGameSessionView: AnyObject {
    
}

final class HistoryGameSessionViewController: UIViewController, IHistoryGameSessionView {
    private let presenter: IHistoryGameSessionPresenter
    private lazy var historyTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(presenter: IHistoryGameSessionPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    private func configureViews() {
        view.addSubview(historyTableView)
        setLayoutConstraints()
    }
    
    private func setLayoutConstraints() {
        NSLayoutConstraint.activate([
            historyTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            historyTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            historyTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            historyTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HistoryGameSessionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        presenter.cellForRow(tableView, at: indexPath)
    }
}

extension HistoryGameSessionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        presenter.heightForRow
    }
}

final class HistoryTableViewCell: UITableViewCell {
    static let identifier = "HistoryTableViewCell" // !!!!!!!!
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "test"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let difficultLabel: UILabel = {
        let label = UILabel()
        label.text = "test2"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let countQuestionsLabel: UILabel = {
        let label = UILabel()
        label.text = "test3"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let answersTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "test4"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configurationViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurationViews() {
        contentView.addSubview(categoryLabel)
        contentView.addSubview(difficultLabel)
        contentView.addSubview(countQuestionsLabel)
        contentView.addSubview(answersTypeLabel)
        setLayoutConstraints()
    }
    
    private func setLayoutConstraints() {
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            difficultLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10),
            difficultLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            difficultLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            countQuestionsLabel.topAnchor.constraint(equalTo: difficultLabel.bottomAnchor, constant: 10),
            countQuestionsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            countQuestionsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            answersTypeLabel.topAnchor.constraint(equalTo: countQuestionsLabel.bottomAnchor, constant: 10),
            answersTypeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            answersTypeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
        ])
    }
}
