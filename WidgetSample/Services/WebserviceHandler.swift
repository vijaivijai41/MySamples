//
//  WebserviceHandler.swift
//  MovieList
//
//  Created by Vijay on 11/06/20.
//  Copyright © 2020 Vijay. All rights reserved.
//


import Foundation


public class WebserviceHandler {
    
    let urlSession: URLSession
    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
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
                            let jsonResult = try? JSONSerialization.jsonObject(with: data, options: []) as? Dictionary<String,AnyObject>
                            
                            print(jsonResult ?? [:])
                            
                        }
                        self.codableConvertModel(fromData: data, returnType: ImageModel.self) { (result) in
                            switch result {
                            case .success(let codable):
                                if let response = codable as? ImageModel {
                                    onCompletion(.success(response))
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
            let decoder = try JSONDecoder().decode(returnType.self, from: data)
            onCompletion(.success(decoder))
        } catch {
            onCompletion(.failure(.serviceError))
        }
    }

}
