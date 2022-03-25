import UIKit

extension URL {
    var queryParameters: QueryParameters { return QueryParameters(url: self) }
}

class QueryParameters {
    let queryItems: [URLQueryItem]
    init(url: URL?) {
        queryItems = URLComponents(string: url?.absoluteString ?? "")?.queryItems ?? []
        print(queryItems)
    }
    
    var params: [String: String] {
        var dict: [String: String] = [:]
        for i in queryItems.enumerated() {
            dict[i.element.name] = i.element.value ?? ""
        }
        return dict
    }
    
    subscript(name: String) -> String? {
        return queryItems.first(where: { $0.name == name })?.value
    }
}

let params = QueryParameters(url: URL(string: "https://example.com/path/to/page?name=ferret&color=purple"
))
print(params.params)
