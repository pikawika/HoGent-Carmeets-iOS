//
//  MessageUtil.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 02/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.
//

import Foundation
import UIKit

/**
 Een util om je te helpen met het weergeven van berichten aan de gebruiker.
 */
class MessageUtil {
    /**
     Toont een toast like bericht aan de gebruiker zonder inputmogelijkheden voor een bepaalde duur.
     
     - Parameter message: bericht dat je wilt weergeven aan gebruiker.
     - Parameter durationInSeconds: aantal seconden dat popup zichtbaar moet blijven.
     - Parameter controller: UIViewController die de functie oproept.
     
     - Parameter completion: optioneel -> zorgt er voor dat je kan calbacken nadat de alert verdwenen is van het scherm.
     */
    static func showToast(withMessage message: String, durationInSeconds: Double, controller: UIViewController, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        controller.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + durationInSeconds) {
            alert.dismiss(animated: true)
            completion?()
        }
    }
}
