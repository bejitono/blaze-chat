//
//  UIView+Theme.swift
//  PHUIKit
//
//  Created by Stefano De Micheli on 1/12/2563 BE.
//

import UIKit

public extension UIView {
    
    func applyShadow() {
        layer.shadowColor = UIColor(red: 0.196, green: 0.196, blue: 0.279, alpha: 0.06).cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 8
    }
}
