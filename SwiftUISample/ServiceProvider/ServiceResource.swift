//
//  ServiceResource.swift
//  SwiftUISample
//
//  Created by Vijay on 19/08/20.
//



import Foundation


public protocol APPDataUpdateProtocol: ObservableObject {
    var apiState: DataUpdateState { get set }
}

public enum DataUpdateState {
    case onloading
    case dataUpdate
    case dateError(error: String)
}

public protocol ErrorReturn {
    var errorString: String { get }
}

public enum ErrorHandler: Error, ErrorReturn {
    case nodata
    case networkError
    case serviceError
    
    public var errorString: String {
        switch self {
        case .networkError:
            return "Network failure"
        case .nodata:
            return "No data found"
        case .serviceError:
            return "Service unavailable"
        }
    }
}



public enum HttpMethod: String {
    case get = "GET"
    case post = "POST"

}

public protocol ServiceResource {
    var baseURL: URL { get }
    var urlRequest: URLRequest? { get }
    var method: String { get }
    var params: [String: String] { get }
    var httpMethod: HttpMethod { get }
    var fileName: String { get }
}

extension ServiceResource {
    // url request formation based on values
    public var urlRequest: URLRequest? {
        let urlComponents = URLComponents(string: (baseURL.absoluteString + method).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
        
        if let url = urlComponents?.url {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = httpMethod.rawValue
            
            if httpMethod == .post {
                if let paramsData = encodeParams() {
                    urlRequest.httpBody = paramsData
                }
                
                // add content type based on types
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            return urlRequest
        }
        return nil
    }
    
    // encoded params to data
    public func encodeParams() -> Data? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: params, options: .fragmentsAllowed)
            return jsonData
        }catch {
            print("error \(error)")
        }
        return nil
    }
}
