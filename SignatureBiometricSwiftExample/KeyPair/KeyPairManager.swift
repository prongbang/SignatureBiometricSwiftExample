//
//  PublicKeyManager.swift
//  SignatureBiometricSwiftExample
//
//  Created by M on 22/12/2565 BE.
//

import Foundation
import CommonCrypto

class KeyPairManager : KeyManager {
    
    private let keychainManager: KeychainManager
    
    private var keyPair: KeyPair?
    
    public init(keychainManager: KeychainManager) {
        self.keychainManager = keychainManager
    }
    
    func create(keyConfig: KeyConfig) -> KeyPair? {
        var key = keychainManager.loadKey(name: keyConfig.name)
        guard key == nil else {
            return key
        }
        
        do {
            keyPair = try keychainManager.makeAndStoreKey(name: keyConfig.name)
            return keyPair
        } catch let error {
            print("Can't create key pair : \(error.localizedDescription)")
        }
        
        return nil
    }
    
    func getOrCreate(keyConfig: KeyConfig) -> KeyPair? {
        guard keyPair == nil else {
            return keyPair
        }
        
        keyPair = self.create(keyConfig: keyConfig)
        guard keyPair != nil else {
            print("Can't create key pair")
            return nil
        }
        
        return keyPair
    }
    
}
