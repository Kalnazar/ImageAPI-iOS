import UIKit

protocol SetValue{
    func setDelegate(country: String, title: String)
}

struct APIResponse: Codable {
    let total: Int
    let total_pages: Int
    let results: [Result]
}

struct Result: Codable {
    let id: String
    let urls: URLS
}

struct URLS: Codable {
    let full: String
}

struct Manager{
    var delegateSetValue: SetValue?
    
    func setValue(isSwitzerland: Bool) {
        if (isSwitzerland){
            delegateSetValue?.setDelegate(country: "switzerland", title: "Switzerland")
        } else{
            delegateSetValue?.setDelegate(country: "america", title: "America")
        }
    }
}
