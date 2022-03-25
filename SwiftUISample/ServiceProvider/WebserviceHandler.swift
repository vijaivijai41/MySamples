//
//  WebserviceHandler.swift
//  SwiftUISample
//
//  Created by Vijay on 19/08/20.
//



import Foundation


public class WebserviceHandler {
    
    let urlSession: URLSession
    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    public func loadJson(networkResource: ServiceResource,onCompletion: @escaping (Result<[InfoModel], ErrorHandler>) -> Void) {
        
        if let url = Bundle.main.url(forResource: networkResource.fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([InfoModel].self, from: data)
                
                onCompletion(.success(jsonData))
            } catch {
               onCompletion(.failure(.nodata))
            }
        }
        
    }
    
    public func loadApiCall(networkResource: ServiceResource,onCompletion: @escaping (Result<Codable, ErrorHandler>) -> Void)  {
        guard let urlRequest = networkResource.urlRequest else {
            return
        }
        
        print(urlRequest)
        self.urlSession.dataTask(with: urlRequest) { (responseData, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                if error != nil {
                    onCompletion(.failure(.serviceError))
                }
                return
            }
            
            DispatchQueue.main.async {
                switch httpResponse.statusCode  {
                case 200..<299:
                    if let data = responseData {
                        do {
                            let jsonResult = try? JSONSerialization.jsonObject(with: data, options: [])
                            print(jsonResult)
                            
                        }
                        
                        self.codableConvertModel(fromData: data, returnType: [InfoModel].self) { (result) in
                            switch result {
                            case .success(let codable):
                                if let response = codable as? [InfoModel] {
                                    onCompletion(.success(response))
                                } else if let  _response = codable as? InfoModel {
                                    onCompletion(.success(_response))
                                } else {
                                    onCompletion(.failure(.nodata))
                                }
                            case .failure(let error):
                                onCompletion(.failure(error))
                            }
                        }
                    }
                default:
                    onCompletion(.failure(.nodata))
                }
            }
        }.resume()
        
    }
    
    // codableConvert for
    public func codableConvertModel<T: Codable>(fromData data: Data, returnType: T.Type, onCompletion:@escaping (Result<Codable, ErrorHandler>) -> ()) {
        do {
            
            if let decoder = try? JSONDecoder().decode(returnType.self, from: data) {
                onCompletion(.success(decoder))
            } else {
                let data = try JSONDecoder().decode(InfoModel.self, from: data)
                    onCompletion(.success(data))
            }
            
        } catch {
            onCompletion(.failure(.serviceError))
        }
    }

}
