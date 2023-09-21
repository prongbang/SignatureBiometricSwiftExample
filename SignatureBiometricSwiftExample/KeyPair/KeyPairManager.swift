//
//  KeyPairManager.swift
//
//
//  Created by M on 23/12/2565 BE.
//

import Foundation
import CommonCrypto

class KeyPairManager : KeyManager {
    
    private let keychainManager: KeychainManager
    private let keyConfig: KeyConfig
    
    init(keyConfig: KeyConfig, keychainManager: KeychainManager) {
        self.keyConfig = keyConfig
        self.keychainManager = keychainManager
    }
    
    func create() -> KeyPair? {
        do {
            let keyPair = try keychainManager.makeAndStoreKey(name: keyConfig.name)
            return keyPair
        } catch let error {
            print("Can't create key pair : \(error.localizedDescription)")
        }
        
        return nil
    }
    
    func getOrCreate() -> KeyPair? {
        let key = keychainManager.loadKey(name: keyConfig.name)
        guard key == nil else {
            return key
        }
        
        let keyPair = self.create()
        guard keyPair != nil else {
            print("Can't create key pair")
            return nil
        }
        
        return keyPair
    }
    
}

