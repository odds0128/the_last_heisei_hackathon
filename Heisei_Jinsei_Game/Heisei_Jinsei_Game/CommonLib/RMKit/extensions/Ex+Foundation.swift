import Foundation

// MARK: - String Extesions in Foundation
extension String{
    func removed(by charset:CharacterSet) -> String{
        return self.components(separatedBy: charset).filter {!$0.isEmpty}.joined()
    }
}
// MARK: - A NotificationCenter Extesion
extension NotificationCenter{
    /// For Easy Use.
    @discardableResult
    func addObserver(forName name: NSNotification.Name, using block: @escaping (Notification) -> Void) -> NSObjectProtocol {
        return self.addObserver(forName: name, object: nil, queue: .main, using: block)
    }
}

// MARK: - URLComponents Extensions
extension URLComponents{
    
    /// UrlParamators converted to Dictionary type.
    var paramators:[String: String?] {
        get{
            return self.queryItems?.reduce(into: [String:String?]()){$0[$1.name] = $1.value} ?? [:]
        }
        set{
            self.queryItems = newValue.map{URLQueryItem(name: $0, value: $1)}
        }
    }
}

extension NSObject{
    func hasProperty(for name:String) -> Bool{
        let checkSelector = NSSelectorFromString(name)
        return self.responds(to: checkSelector)
    }
}
