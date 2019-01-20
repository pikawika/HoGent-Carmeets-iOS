//
//  SharedApplicationUtil.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 02/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.
//

import Foundation
import UIKit

/**
 Een util om je te helpen met het communciren met appplicaties van derden.
 */
class SharedApplicationUtil {
    /**
     Opent Apple Maps voor navigatie te starten.
     
     - Parameter withMarkerOnLocation: location object waar de marker moet geplaatst worden.
     */
    static func openNavigation(withMarkerOnLocation location: Location) {
        let baseMapsUrl: String = "http://maps.apple.com/?q="
        let locationURLPart = LocationUtil.fullAdressNotation(fromLocation: location).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL(string: baseMapsUrl + locationURLPart) else { return }
        UIApplication.shared.open(url)
    }
    
    /**
     Opent browersapplicatie voor een website weer te geven.
     
     - Parameter withUrl: URL die de browser moet openen.
     */
    static func openWebsite(withUrl url: String) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
}
