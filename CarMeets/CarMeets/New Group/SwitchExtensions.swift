//
//  SwitchExtensions.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 19/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.
//

import Foundation

import UIKit

//  Source for inspiration (also mentioned in Readme)
//      https://stackoverflow.com/a/50782478
/**
 Een label zodanig uitgebreid dat je er op kan klikken en hij een overridable onClick methode heeft.
 */
@IBDesignable class SwitchOnClick: UISwitch {
    var onClick: () -> Void = {}
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        onClick()
    }
}
