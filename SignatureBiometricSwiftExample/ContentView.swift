//
//  ContentView.swift
//  SignatureBiometricSwiftExample
//
//  Created by M on 22/12/2565 BE.
//

import SwiftUI
import CommonCrypto
import LocalAuthentication

struct ContentView: View {
    
    @State var signed = ""
    @State var verify = ""
    @State var publicKey = ""
    
    private let clearText = "Hello"
    
    private let signatureBiometricManager = LocalSignatureBiometricManager.newInstance(
        keyConfig: KeyConfig(name: "com.krungsri.wemerchant.kSecAccKey")
    )
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            
            Text("PublicKey: \(publicKey)")
            Button("Create KeyPair", action: {
                processCreateKeyPair()
            }).padding()
            
            Button("Sign", action: {
                processSign()
            }).padding()
            Text("Signature: \(signed)")
            
            Button("Verify", action: {
                processVerify()
            }).padding()
            Text("Verify: \(verify)")
        }
        .padding()
    }
    
    func processCreateKeyPair() {
        let reason = "Please scan your fingerprint (or face) to authenticate"
        signatureBiometricManager.createKeyPair(reason: reason) { result in
            // EX: MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEeRx7Mqq0N+HVxnVpqJugHxC69iDhsQF8erFV8TbBPkk9NP6p7H0ren2C/rsdzibIpRouirNJqNoHvfNOhDvc2A==
            if result.status == SignatureBiometricStatus.success {
                self.publicKey = result.publicKey ?? ""
                
                print("publicKey: \(self.publicKey)")
            } else {
                print("CreateKeyPair Error: \(result.status)")
            }
        }
    }
    
    func processSign() {
        signatureBiometricManager.sign(payload: clearText) { result in
            
            if result.status == SignatureBiometricStatus.success {
                self.signed = result.signature ?? ""
                print("signature: \(String(describing: result.signature))")
            } else {
                print("Sign Error: \(result.status)")
            }
        }
    }
    
    func processVerify() {
        let reason = "Please scan your fingerprint (or face) to authenticate"
        signatureBiometricManager.verify(reason: reason, payload: clearText, signature: signed) { result in
            
            if result.status == SignatureBiometricStatus.success {
                self.verify = "\(result.verified)"
                
                print("verify: \(result.verified)")
            } else {
                self.verify = "false"
                
                print("Sign Error: \(result.status)")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
