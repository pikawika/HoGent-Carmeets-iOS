//
//  KeyChainUtil.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 18/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.

import Foundation
import KeychainSwift

/**
 Util om je te helpen werken met de Apple's KeyChain.
 */
class KeyChainUtil {
    /**
     Slaat de token op in een KeyChain.
     
     - Parameter withValue: de token (string) die je wilt opslaan in een KeyChain.
     */
    static func setTokenInKeychain(withValue token: String) {
        let keychain = KeychainSwift()
        keychain.set(token, forKey: "carmeets token")
    }
    
    /**
     Haalt de token op uit een KeyChain.
     
     - Returns: De token met als default empty string ("").
     */
    static func getTokenFromKeychain() -> String {
        let keychain = KeychainSwift()
        return keychain.get("carmeets token") ?? ""
    }
    
    /**
     Verwijderd alle items van de app uit keychain.
     */
    static func clearKeychain() {
        let keychain = KeychainSwift()
        keychain.clear()
    }
    
    /**
     Kijkt of een user is opgeslaan in KeyChain en returnt dus of user al dan niet al aangemeld is.
     
     - Returns: Boolean of user al da niet aangemeld is.
     */
    static func isUserLoggedIn() -> Bool{
        let keychain = KeychainSwift()
        return !(keychain.get("carmeets token") ?? "").isEmpty
    }
    
}
