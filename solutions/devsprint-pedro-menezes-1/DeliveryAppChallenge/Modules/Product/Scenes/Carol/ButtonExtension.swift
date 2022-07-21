//
//  ButtonExtension.swift
//  DeliveryAppChallenge
//
//  Created by carolina.quiterio on 20/07/22.
//

import UIKit
import Foundation

extension UIButton {
    func setupStyle(cornerRadiusHeight: CGFloat) {
        self.layer.cornerRadius = cornerRadiusHeight / 2
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.blue.cgColor
        self.setTitleColor(.blue, for: .normal)
        self.backgroundColor = .white
    }
}
