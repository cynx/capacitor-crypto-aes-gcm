import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@available(iOS 13.0, *)
@objc(CryptoPlugin)
public class CryptoPlugin: CAPPlugin {
    private let implementation = Crypto()

    @objc func encrypt(_ call: CAPPluginCall) {
        guard let base64Encoded = call.getString("base64Encoded") else {
            call.reject("'base64Encoded' value must be provided")
            return
        }
        
        guard let text = call.getString("text") else {
            call.reject("'text' value must be provided")
            return
        }
        
        implementation.encrypt(text: text, base64Encoded: base64Encoded) { (result, success) in
            
            if success {
                call.resolve([
                    "encrypted": result
                ])
            } else {
                call.reject(result)
            }
        }
    }

    @objc func decrypt(_ call: CAPPluginCall) {
        guard let base64Encoded = call.getString("base64Encoded") else {
            call.reject("'base64Encoded' value must be provided")
            return
        }
        
        guard let text = call.getString("text") else {
            call.reject("'text' value must be provided")
            return
        }
        
        implementation.decrypt(text: text, base64Encoded: base64Encoded) { (result, success) in
            if success {
                call.resolve([
                    "decrypted": result
                ])
            } else {
                call.reject(result)
            }
        }
    }
    
    @objc func generateSymmetricKey(_ call: CAPPluginCall) {
        call.resolve([
            "key256": implementation.generateSymmetricKey()
        ])
    }
}
