//
//  HistoryListCoordinator.swift
//  Quizly
//
//  Created by Анатолий Лушников on 11.05.2025.
//

import UIKit

final class HistoryListCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showModule()
    }
    
    func goBack() {
        finish()
        navigationController.popToRootViewController(animated: true)
    }
    
    func showImagePicker(with imagePicker: UIImagePickerController) {
        navigationController.present(imagePicker, animated: true)
    }
    
    func dismissImagePicker() {
        navigationController.topViewController?.dismiss(animated: true)
    }
    
    func presentView(with activity: UIActivityViewController) {
        navigationController.present(activity, animated: true)
    }
}

private extension HistoryListCoordinator {
    func showModule() {
        // !!!!! 
    }
}
