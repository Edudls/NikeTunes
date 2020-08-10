//
//  UILabelExtension.swift
//  NikeTunes
//
//  Created by DMonaghan on 8/10/20.
//  Copyright © 2020 DMonaghan. All rights reserved.
//

import UIKit

extension UILabel {
    
    convenience init(alignment: NSTextAlignment, textColor: UIColor? = nil, font: CGFloat? = nil) {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.numberOfLines = 0
        self.textAlignment = alignment
        if let textColor = textColor {
            self.textColor = textColor
        }
        if let font = font {
            self.font = self.font.withSize(font)
        }
    }
    
}


