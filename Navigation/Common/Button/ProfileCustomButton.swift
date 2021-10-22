//
//  ProfileCustomButton.swift
//  Navigation
//
//  Created by a.agataev on 22.10.2021.
//

import UIKit

class ProfileCustomButton: UIButton {
    
    private enum Constants {
        static let showStatusButtonColor: CGColor = UIColor.blue.cgColor
        static let showStatusButtonCornerRadius: CGFloat = 4.0
        static let showStatusShadowOffset: CGSize = CGSize(width: 4, height: 4)
        static let showStatusShadowRadius: CGFloat = 4.0
        static let showStatusShadowColor: CGColor = UIColor.black.cgColor
        static let showStatusShadowOpacity: Float = 0.7
        static let showStatusButtonHeight: CGFloat = 50.0
    }
    
    lazy var shadowLayer: CAShapeLayer = {
        shadowLayer = CAShapeLayer()
        return shadowLayer
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 4).cgPath
        
        shadowLayer.fillColor = Constants.showStatusButtonColor
        shadowLayer.shadowColor = Constants.showStatusShadowColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = Constants.showStatusShadowOffset
        shadowLayer.shadowOpacity = Constants.showStatusShadowOpacity
        shadowLayer.shadowRadius = Constants.showStatusShadowRadius
        
        layer.insertSublayer(shadowLayer, at: 0)
    }
}
