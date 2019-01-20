//
//  MessageUtil.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 02/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.
//

import Foundation
import UIKit

class MessageUtil {
    /**
     Toont een toast like bericht aan de gebruiker zonder inputmogelijkheden voor een bepaalde duur.
     
     - Parameter message: bericht dat je wilt weergeven aan gebruiker.
     - Parameter durationInSeconds: aantal seconden dat popup zichtbaar moet blijven.
     - Parameter controller: UIViewController die de functie oproept.
     
     - Returns: String in formaat -> icon + category1 | category2
     */
    static func showToast(message: String, durationInSeconds: Double, controller: UIViewController, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        controller.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + durationInSeconds) {
            alert.dismiss(animated: true)
            completion?()
        }
    }
}
