//
//  UINavigationController + createTab.swift
//  Quizly
//
//  Created by Анатолий Лушников on 13.06.2025.
//

import UIKit

extension UINavigationController {
    func addTabBarItem(
        with title: String?,
        image: UIImage?,
        selectedImage: UIImage? = nil
    ) {
        self.tabBarItem = UITabBarItem(
            title: title,
            image: image,
            selectedImage: selectedImage
        )
    }
}
