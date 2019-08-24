//
//  DataManager.swift
//  MatchMe
//
//  Created by Abdus Mac on 8/7/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import Foundation

protocol APIManagerProtocol {
    typealias Handler = (Result<Data, APIManager.RequestError>) -> Void

    func requestData(path: String, method: APIManager.HTTPMethod, parameters: APIManager.parameters?, completion: @escaping Handler)
}

class APIManager: APIManagerProtocol {
    
    static let baseUrl = "https://raw.githubusercontent.com/sparknetworks/coding_exercises_options/master/filtering_matches/database/matches.json"
    
    typealias parameters = [String:Any]
    
    enum HTTPMethod: String {
        case get     = "GET"
    }
    
    enum RequestError: Error {
        case unknownError
        case connectionError
        case authorizationError([String:Any])
        case invalidRequest
        case notFound
        case invalidResponse
        case serverError
        case serverUnavailable
        
        var localizedDescription: String {
            switch self {
            case .connectionError:
                return "The Internet connection appears to be offline"
            default: return "Some thing went wrong"
            }
        }
        
    }
    
    func requestData(path:String, method: HTTPMethod, parameters: parameters?,completion: @escaping Handler) {
        
        var parameterData = ""
        if let parameters = parameters {
            parameterData = parameters.reduce("?") { (result, param) -> String in
                return result + "&\(param.key)=\((param.value as? String ?? ""))"
            }
        }
        guard let url = URL(string: APIManager.baseUrl + parameterData) else { return }
        var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        urlRequest.httpMethod = method.rawValue
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print(error)
                completion(.failure(.connectionError))
            }
            else if let data = data ,let responseCode = response as? HTTPURLResponse {
                do {
                    
                    switch responseCode.statusCode {
                    case 200:
                        
                        completion(.success(data))
                    case 400...499:
                        guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String: Any] else {                         completion(.failure(.unknownError))
                            return }

                        completion(.failure(.authorizationError(json)))
                    case 500...599:
                        completion(.failure(.serverError))
                    default:
                        completion(.failure(.unknownError))
                        break
                    }
                }
                catch let parseJSONError {
                    completion(.failure(.unknownError))
                    print("error on parsing request to JSON : \(parseJSONError)")
                }
            }
            }.resume()
    }
}
