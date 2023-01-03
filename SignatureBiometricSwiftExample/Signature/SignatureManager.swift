//
//  SignatureManager.swift
//  SignatureBiometricSwiftExample
//
//  Created by M on 22/12/2565 BE.
//

import Foundation

protocol SignatureManager {
    func sign(algorithm: SecKeyAlgorithm, data: Data) -> SignatureResult
    func sign(message: String) -> SignatureResult
    func verify(message: String, signature: String) -> Bool
}
