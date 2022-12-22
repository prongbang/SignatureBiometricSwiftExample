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
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Text("Signature: \(signed)")
            Text("Verify: \(verify)")
        }
        .padding()
        .onAppear {
            signature()
        }
    }
    
    func signature() {
        
        let keyConfig = KeyConfig(name: "com.krungsri.wemerchant.kSecAccKey")
        let keychainManager = KeychainAccessManager()
        let keyPairManager = KeyPairManager(keychainManager: keychainManager)
        let signatureManager = BiometricSignatureManager(
            keyManager: keyPairManager,
            keyConfig: keyConfig
        )
        
        let keyPair = keyPairManager.getOrCreate(keyConfig: keyConfig)
        let pk = keyPair?.publicKey?.toBase64Pretty()
        let pemString = keyPair?.publicKey?.toPem()
        print("pk: \(pk)") // MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEeRx7Mqq0N+HVxnVpqJugHxC69iDhsQF8erFV8TbBPkk9NP6p7H0ren2C/rsdzibIpRouirNJqNoHvfNOhDvc2A==
        print("pemString: \(pemString)")
        
        
        let clearText = "Hello"
        let signature = signatureManager.sign(message: clearText) ?? ""
        
        self.signed = signature
        
        print("signature: \(signature)")
        
        let verify = signatureManager.verify(message: clearText, signature: signature)
        
        self.verify = "\(verify)"
        
        print("verify: \(verify)")
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
