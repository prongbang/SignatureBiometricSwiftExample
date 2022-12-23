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
                createKeyPair()
            })
            Button("Sign & Verify", action: {
                signAndVerify()
            })
            Text("Signature: \(signed)")
            Text("Verify: \(verify)")
        }
        .padding()
    }
    
    func createKeyPair() {
        let reason = "Please scan your fingerprint (or face) to authenticate"
        signatureBiometricManager.createKeyPair(reason: reason) { result in
            // EX: MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEeRx7Mqq0N+HVxnVpqJugHxC69iDhsQF8erFV8TbBPkk9NP6p7H0ren2C/rsdzibIpRouirNJqNoHvfNOhDvc2A==
            if result.status == "success" {
                self.publicKey = result.publicKey ?? ""
            } else {
                print("Error: \(result.status)")
            }
        }
    }
    
    func signAndVerify() {
        
        let clearText = "Hello"
        signatureBiometricManager.sign(payload: clearText) { signature in
            self.signed = signature ?? ""
            print("signature: \(String(describing: signature))")
        }
        
        
        signatureBiometricManager.verify(payload: clearText, signature: signed) { verified in
            self.verify = "\(verified)"
            
            print("verify: \(verified)")
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
