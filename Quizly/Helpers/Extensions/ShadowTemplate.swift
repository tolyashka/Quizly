//
//  ShadowTemplate.swift
//  Quizly
//
//  Created by Анатолий Лушников on 12.05.2025.
//

import UIKit

extension UIView {
    private var defaultShadowOpacity: Float {
        return 0.175
    }
    
    private var defaultShadowRadius: CGFloat {
        return 6
    }
    
    private var defaultShadowWidth: CGFloat {
        return 0.0
    }
    
    private var defaultShadowHeight: CGFloat {
        return 4.0
    }
    
    func setDefaultShadow() {
        layer.shadowOpacity = defaultShadowOpacity
        layer.shadowRadius = defaultShadowRadius
        layer.shadowOffset = CGSize(width: defaultShadowWidth, height: defaultShadowHeight)
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
}
