//
//  SharedApplicationUtil.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 02/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.
//

import Foundation
import UIKit

class SharedApplicationUtil {
    /**
     Opent Apple Maps voor navigatie te starten.
     
     - Parameter for: location object waarvoor route getoond moet worden
     */
    static func openNavigation(for location: Location) {
        let baseMapsUrl: String = "http://maps.apple.com/?q="
        let locationURLPart = LocationUtil.fullAdressNotation(from: location).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL(string: baseMapsUrl + locationURLPart) else { return }
        UIApplication.shared.open(url)
    }
    
    /**
     Opent browersapplicatie voor een website weer te geven.
     
     - Parameter onURL: URL die de browser moet openen.
     */
    static func openWebsite(url: String) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
}
