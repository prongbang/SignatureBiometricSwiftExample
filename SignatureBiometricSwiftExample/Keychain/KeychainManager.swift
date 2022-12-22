//
//  KeychainManager.swift
//  SignatureBiometricSwiftExample
//
//  Created by M on 22/12/2565 BE.
//

import Foundation

protocol KeychainManager {
    func loadKey(name: String) -> KeyPair?
    func removeKey(name: String)
    func makeAndStoreKey(name: String) throws -> KeyPair
}
