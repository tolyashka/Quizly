//
//  ShadowTemplate.swift
//  Quizly
//
//  Created by Анатолий Лушников on 12.05.2025.
//

import UIKit

extension UIView {
    func setDefaultShadow() {
        layer.shadowOpacity = 0.175
        layer.shadowRadius = 6
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
}
