//
//  TabBarController.swift
//  Quizly
//
//  Created by Анатолий Лушников on 06.05.2025.
//

import UIKit

final class TabBarController: UITabBarController {
    init(tabBarControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        for tab in tabBarControllers {
            addChild(tab)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
