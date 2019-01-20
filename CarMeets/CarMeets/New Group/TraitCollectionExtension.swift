//
//  TraitCollectionExtension.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 20/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.
//

import Foundation
import UIKit

extension UITraitCollection {
    var isIpad: Bool {
        return horizontalSizeClass == .regular && verticalSizeClass == .regular
    }
}
