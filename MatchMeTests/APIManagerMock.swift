//
//  APIManagerMock.swift
//  MatchMeTests
//
//  Created by Abdus Mac on 8/22/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import Foundation
@testable import MatchMe
class APIManagerMock: APIManagerProtocol {
    
    private var jsonData: Data?
    private var error: Error?
    
    init(expectedJSON: Data? = nil, expectedError: Error? = nil) {
        jsonData = expectedJSON
        error = expectedError
    }
    
    func requestData(path: String, method: APIManager.HTTPMethod, parameters: APIManager.parameters?, completion: @escaping APIManager.Handler) {
        if error != nil {
            completion(.failure(.serverError))
            return
        }
        
        if let json = jsonData {
            completion(.success(json))
            return
        }
        
        completion(.failure(.unknownError))
    }
}
