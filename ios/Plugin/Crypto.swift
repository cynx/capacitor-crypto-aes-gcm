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

    @objc public func encrypt(text: String, base64Encoded: String) -> String {
        do {
            guard let deserialisedSymmetricKey = SymmetricKey(base64EncodedString: base64Encoded) else { 
                return "Could not decode key: \(base64Encoded)" 
            }
            print("deserialsed key \(deserialisedSymmetricKey)")
            let textData = text.data(using: .utf8)!
            let encrypted = try AES.GCM.seal(textData, using: deserialisedSymmetricKey)
            return encrypted.combined!.base64EncodedString()}
        catch {
            return "Error encrypting"
        }
    }

     @objc public func decrypt(text: String, base64Encoded: String) -> String {
       do {
            guard let deserialisedSymmetricKey = SymmetricKey(base64EncodedString: base64Encoded) else {
                return "Could not decode key: \(base64Encoded)"
            }
            guard let data = Data(base64Encoded: text) else {
                return "Could not decode text: \(text)"
            }
            let sealedBox = try AES.GCM.SealedBox(combined: data)
            let decryptedData = try AES.GCM.open(sealedBox, using: deserialisedSymmetricKey)
            guard let text = String(data: decryptedData, encoding: .utf8) else {
                return "Could not decode data: \(decryptedData)"
            }
            return text
        }
        catch let error {
            return "Error decrypting message: \(error.localizedDescription)"
        }
    }

    @objc public func generateSymmetricKey() -> String {
        let key256:String = SymmetricKey(size: .bits256).serialize()
        print(key256)
        return key256
    }
}
