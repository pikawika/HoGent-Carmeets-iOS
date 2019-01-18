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
     Slaat de token op in een KeyChain.
     
     - Parameter withToken: de token (string) die je wilt opslaan in een KeyChain.
     */
    static func getUsernameFromToken() -> String {
        guard let jwt = try? decode(jwt: KeyChainUtil.getTokenFromKeychain()) else { return "gebruiker" }
        
        let claim = jwt.claim(name: "username")
        if let email = claim.string {
            return email
        }
        
        return "gebruiker"
    }
    
}


