//
//  SignatureManager.swift
//  SignatureBiometricSwiftExample
//
//  Created by M on 22/12/2565 BE.
//

import Foundation

protocol SignatureManager {
    func sign(algorithm: SecKeyAlgorithm, data: Data) -> String?
    func sign(message: String) -> String?
    func verify(message: String, signature: String) -> Bool
}
