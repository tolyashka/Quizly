//
//  Coordinator.swift
//  Quizly
//
//  Created by Анатолий Лушников on 06.05.2025.
//

import Foundation

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    
    func start()
    func finish()
}

protocol CoordinatorDetail: AnyObject {
    func showDetail(with url: String)
}

extension Coordinator {
    func finish() {
        _ = parentCoordinator?.childCoordinators.popLast()
        parentCoordinator = nil
    }
}
