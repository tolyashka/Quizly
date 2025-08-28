//
//  IQuestionConfiguratorView.swift
//  Quizly
//
//  Created by Анатолий Лушников on 29.05.2025.
//

import UIKit

protocol IQuestionConfiguratorView: AnyObject, UIViewController {
    func updateCurrentConfiguration(with title: String)
}
