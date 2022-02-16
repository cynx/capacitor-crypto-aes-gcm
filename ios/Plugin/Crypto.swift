import Foundation
import CryptoKit


@available(iOS 13.0, *)
extension SymmetricKey {

    // MARK: Custom Initializers

    /// Creates a `SymmetricKey` from a Base64-encoded `String`.
    ///
    /// - Parameter base64EncodedString: The Base64-encoded string from which to generate the `SymmetricKey`.
    init?(base64EncodedString: String) {
        guard let data = Data(base64Encoded: base64EncodedString) else {
            return nil
        }

        self.init(data: data)
    }

    // MARK: - Instance Methods

    /// Serializes a `SymmetricKey` to a Base64-encoded `String`.
    func serialize() -> String {
        return self.withUnsafeBytes { body in
            Data(body).base64EncodedString()
        }
    }
}

@available(iOS 13.0, *)
@objc public class Crypto: NSObject {

    @objc public func encrypt(text: String, base64Encoded: String, completionHandler: (_ result: String, _ success: Bool) ->Void ) {
        do {
            guard let deserialisedSymmetricKey = SymmetricKey(base64EncodedString: base64Encoded) else {
                completionHandler("Could not decode key: \(base64Encoded)", false)
                return
            }
            let textData = text.data(using: .utf8)!
            let encrypted = try AES.GCM.seal(textData, using: deserialisedSymmetricKey)
            completionHandler(encrypted.combined!.base64EncodedString(), true)
        }
        catch let error {
            completionHandler("Error encrypting message: \(error.localizedDescription)", false)
        }
    }

    @objc public func decrypt(text: String, base64Encoded: String, completionHandler:(_ result: String, _ success: Bool) ->Void) {
       do {
            guard let deserialisedSymmetricKey = SymmetricKey(base64EncodedString: base64Encoded) else {
                completionHandler("Could not decode key: \(base64Encoded)", false)
                return
            }
            guard let data = Data(base64Encoded: text) else {
                completionHandler("Could not decode key: \(text)", false)
                return
            }
            let sealedBox = try AES.GCM.SealedBox(combined: data)
            let decryptedData = try AES.GCM.open(sealedBox, using: deserialisedSymmetricKey)
            guard let text = String(data: decryptedData, encoding: .utf8) else {
                completionHandler("Could not decode key: \(decryptedData)", false)
                return
            }
           completionHandler(text, true)
        }
        catch let error {
            completionHandler ("Error decrypting message: \(error.localizedDescription)", false)
        }
    }

    @objc public func generateSymmetricKey() -> String {
        let key256:String = SymmetricKey(size: .bits256).serialize()
        return key256
    }
}
