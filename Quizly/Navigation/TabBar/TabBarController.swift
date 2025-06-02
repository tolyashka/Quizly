//
//  TabBarController.swift
//  Quizly
//
//  Created by Анатолий Лушников on 06.05.2025.
//

import UIKit

final class TabBarController: UITabBarController {
    private let tabBarControllers: [UIViewController]
    
    init(tabBarControllers: [UIViewController]) {
        self.tabBarControllers = tabBarControllers
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for tab in tabBarControllers {
            addChild(tab)
        }
    }
}
