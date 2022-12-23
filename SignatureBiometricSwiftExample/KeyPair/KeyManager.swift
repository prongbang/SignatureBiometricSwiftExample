//
//  KeyPairManager.swift
//  SignatureBiometricSwiftExample
//
//  Created by M on 22/12/2565 BE.
//

import Foundation

protocol KeyManager {
    func create() -> KeyPair?
    func getOrCreate() -> KeyPair?
}
