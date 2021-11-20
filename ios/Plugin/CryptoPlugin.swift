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
        let base64Encoded = call.getString("base64Encoded") ?? ""
        let text = call.getString("text") ?? ""
        call.resolve([
            "encrypted": implementation.encrypt(text: text, base64Encoded: base64Encoded)
        ])
    }

    @objc func decrypt(_ call: CAPPluginCall) {
        let base64Encoded = call.getString("base64Encoded") ?? ""
        let text = call.getString("text") ?? ""
        call.resolve([
            "decrypted": implementation.decrypt(text: text, base64Encoded: base64Encoded)
        ])
    }
    
    @objc func generateSymmetricKey(_ call: CAPPluginCall) {
        call.resolve([
            "key256": implementation.generateSymmetricKey()
        ])
    }
}
