//
//  LabelButtonExtension.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 18/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.
//  Zie bronnen voor inspiratie code
//      https://stackoverflow.com/a/50782478
import UIKit

/**
 Geeft een label de mogelijkheid om clickbaar te zijn met onClick methode.
 */
@IBDesignable class LabelButton: UILabel {
    var onClick: () -> Void = {}
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        onClick()
    }
}
