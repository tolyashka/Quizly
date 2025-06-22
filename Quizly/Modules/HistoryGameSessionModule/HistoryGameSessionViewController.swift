//
//  HistoryGameSessionViewController.swift
//  Quizly
//
//  Created by Анатолий Лушников on 20.06.2025.
//

import UIKit

protocol IHistoryGameSessionView: AnyObject {
    func updateTableView()
}

final class HistoryGameSessionViewController: UIViewController {
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
        navigationItem.title = "История"
         // В НАСТРОЙКУ ПЕРЕКИНУТЬ 
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.isNavigationBarHidden = false
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

extension HistoryGameSessionViewController: IHistoryGameSessionView {
    func updateTableView() {
        historyTableView.reloadData()
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
    
    private let percentResultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 20
        label.clipsToBounds = true
        label.backgroundColor = .systemGreen.withAlphaComponent(0.5)
        label.font = .boldSystemFont(ofSize: 22)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let difficultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateSessionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .italicSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let resultSessionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 22)
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
    
    func updateValue(with gameSessionModel: GameSession) {
        self.percentResultLabel.text = setPercentResultTitle(gameSessionModel.result.percent)
        self.categoryLabel.text = setCategoryLabel(text: gameSessionModel.config.title)
        self.difficultLabel.text = setDifficultTitle(text: gameSessionModel.config.difficultyLevel)
        self.resultSessionLabel.text = setResultTitle(gameSessionModel.result)
        self.dateSessionLabel.text = setDataSessionTitle(gameSessionModel.result.date)
    }
    private func configurationViews() {
        contentView.addSubview(categoryLabel)
        contentView.addSubview(difficultLabel)
        contentView.addSubview(dateSessionLabel)
        contentView.addSubview(resultSessionLabel)
        contentView.addSubview(percentResultLabel)
        setLayoutConstraints()
    }
    
    private func setLayoutConstraints() {
        NSLayoutConstraint.activate([
            // STACK
            percentResultLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            percentResultLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            percentResultLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            percentResultLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25),
            
            categoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            categoryLabel.leadingAnchor.constraint(equalTo: percentResultLabel.trailingAnchor, constant: 5),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            difficultLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 5),
            difficultLabel.leadingAnchor.constraint(equalTo: percentResultLabel.trailingAnchor, constant: 5),
            difficultLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            resultSessionLabel.topAnchor.constraint(equalTo: difficultLabel.bottomAnchor, constant: 5),
            resultSessionLabel.leadingAnchor.constraint(equalTo: percentResultLabel.trailingAnchor, constant: 5),
            resultSessionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            dateSessionLabel.topAnchor.constraint(equalTo: resultSessionLabel.bottomAnchor, constant: 10),
            dateSessionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
        ])
    }
}

private extension HistoryTableViewCell {
    func setPercentResultTitle(_ percent: Double?) -> String {
        let defaultTitle = "Значение отсутствует"
        guard let percent else { return defaultTitle }
        let title = String(percent) + "%"
        return title
    }
    
    func setCategoryLabel(text: String?) -> String {
        let defaultTitle = "Категория неизвестна"
        guard let text else { return defaultTitle }
        let title = "Категория:" + " " + text
        return title
    }
    
    func setDifficultTitle(text: String?) -> String {
        let defaultTitle = "Сложность неизвестна"
        guard let text else { return defaultTitle }
        let title = "Сложность вопросов:" + " " + text
        return title
    }
    
    func setResultTitle(_ result: QuizResultModel) -> String {
        let title = String(result.score) + " / " + String(result.total)
        return title
    }
    
    func setDataSessionTitle(_ date: Date?) -> String {
        let defaultTitle = "Дата неизвестна"
        guard let date else { return defaultTitle }
        return date.description
    }
}
