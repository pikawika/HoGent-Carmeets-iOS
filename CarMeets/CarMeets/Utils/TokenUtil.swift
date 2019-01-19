//
//  TokenUtil.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 19/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.
//

import Foundation
import JWTDecode

class TokenUtil {
    /**
     Haalt de token op uit de KeyChain en haalt de gebruikersnaam er uit.
     */
    static func getUsernameFromToken() -> String {
        guard let jwt = try? decode(jwt: KeyChainUtil.getTokenFromKeychain()) else { return "gebruiker" }
        
        let claim = jwt.claim(name: "username")
        if let username = claim.string {
            return username
        }
        
        return "gebruiker"
    }
    
    /**
     Haalt de token op uit de KeyChain en haalt de gebruikersId er uit.
     */
    static func getUserIdFromToken() -> String {
        guard let jwt = try? decode(jwt: KeyChainUtil.getTokenFromKeychain()) else { return "-1" }
        
        let claim = jwt.claim(name: "_id")
        if let userId = claim.string {
            return userId
        }
        
        return "-1"
    }
    
}


