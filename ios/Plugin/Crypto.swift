import Foundation

@objc public class Crypto: NSObject {
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }
}
