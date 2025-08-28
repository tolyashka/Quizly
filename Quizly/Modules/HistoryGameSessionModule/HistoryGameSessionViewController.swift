//
//  HistoryGameSessionViewController.swift
//  Quizly
//
//  Created by Анатолий Лушников on 20.06.2025.
//

import UIKit

protocol IHistoryGameSessionView: AnyObject {
//    func updateTableView()
}

final class HistoryGameSessionViewController: UIViewController {
    private let presenter: IHistoryGameSessionPresenter
    
    private lazy var historyTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.identifier)
        tableView.delegate = self
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
        navigationItem.title = "История"
        configureViews()
    }
    
    private func configureViews() {
        view.addSubview(historyTableView)
        setLayoutConstraints()
        presenter.configureDataSource(for: historyTableView)
        presenter.viewDidLoaded(self)
    }
    
    private func setLayoutConstraints() {
        NSLayoutConstraint.activate([
            historyTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            historyTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            historyTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            historyTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HistoryGameSessionViewController: IHistoryGameSessionView {
//    func updateTableView() {
//        historyTableView.reloadData()
//    }
}

extension HistoryGameSessionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        presenter.heightForRow
    }
}

final class HistoryTableViewCell: UITableViewCell {
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
    
    private let dateSessionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .italicSystemFont(ofSize: 18)
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
    // !!!!! cringe
    func updateValue(with gameSessionModel: QuizResultModel) {
        let date = gameSessionModel.date
        
        self.dateSessionLabel.text = date.toString()
        self.percentResultLabel.text = "\(gameSessionModel.percent)"
        
        if gameSessionModel.percent > 50 {
            percentResultLabel.backgroundColor = .systemGreen.withAlphaComponent(0.5)
        } else {
            percentResultLabel.backgroundColor = .systemRed.withAlphaComponent(0.5)
        }
        
        self.resultSessionLabel.text = "\(gameSessionModel.score) / \(gameSessionModel.questionsCount)"
    }
    
    private func configurationViews() {
        contentView.addSubview(dateSessionLabel)
        contentView.addSubview(resultSessionLabel)
        contentView.addSubview(percentResultLabel)
        setLayoutConstraints()
    }
    
    private func setLayoutConstraints() {
        NSLayoutConstraint.activate([
            percentResultLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            percentResultLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            percentResultLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            percentResultLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            
            resultSessionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            resultSessionLabel.leadingAnchor.constraint(equalTo: percentResultLabel.trailingAnchor, constant: 5),
            resultSessionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            dateSessionLabel.topAnchor.constraint(equalTo: resultSessionLabel.bottomAnchor, constant: 10),
            dateSessionLabel.leadingAnchor.constraint(equalTo: percentResultLabel.trailingAnchor, constant: 10),
            dateSessionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
    }
}
