//
//  TraitCollectionExtension.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 20/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.
//

import Foundation
import UIKit

/**
 Eenvoudigere manier voor het bepalen of de huige omgeving van een specifiek soort is.
 */
extension UITraitCollection {
    /**
     Huidige omgeving is Ipad (wRxhR)
     */
    var isIpad: Bool {
        return horizontalSizeClass == .regular && verticalSizeClass == .regular
    }
}
