//
//  LabelExtensions.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 19/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.
//

import UIKit

//  Source for inspiration ((edited to suite my needs | also mentioned in Readme))
//      https://stackoverflow.com/a/32368958
/**
 Een label zodanig uitgebreid dat er een padding voorzien is van 10 links rechts en 5 boven onder. Ideaal voor achtergrondkleur in te stellen dat visueel aantrekkelijk is.
 */
@IBDesignable class LabelWithPadding: UILabel {
    
    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 10.0
    @IBInspectable var rightInset: CGFloat = 10.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}

//  Source for inspiration (also mentioned in Readme)
//      https://stackoverflow.com/a/50782478
/**
 Een label zodanig uitgebreid dat je er op kan klikken en hij een overridable onClick methode heeft.
 */
@IBDesignable class LabelButton: UILabel {
    var onClick: () -> Void = {}
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        onClick()
    }
}

