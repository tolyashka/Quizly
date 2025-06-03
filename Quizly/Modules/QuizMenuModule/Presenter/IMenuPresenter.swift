//
//  IMenuPresenter.swift
//  Quizly
//
//  Created by Анатолий Лушников on 11.05.2025.
//

import UIKit

typealias IMenuPresenter = CategoryMenuLifeCycle & CategoryMenuHandler

protocol CategoryMenuLifeCycle: AnyObject {
    func viewDidLoad(view: IStartMenuView)
}

protocol CategoryMenuHandler: AnyObject {
    func chooseCategory()
    func startQuizSession()
}
