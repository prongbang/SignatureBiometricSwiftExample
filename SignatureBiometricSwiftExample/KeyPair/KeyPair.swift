//
//  KeyPair.swift
//  SignatureBiometricSwiftExample
//
//  Created by M on 22/12/2565 BE.
//

import Foundation
import CommonCrypto

struct KeyPair {
    let privateKey: SecKey?
    let publicKey: SecKey?
}
