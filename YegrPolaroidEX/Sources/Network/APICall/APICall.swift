//
//  APICall.swift
//  YegrPolaroidEX
//
//  Created by YJ on 7/24/24.
//

import Foundation
import Alamofire

class APICall {
    static let shared = APICall()
    private init() { }
    
    func callRequest<T:Decodable>(api: APIRequest, model: T.Type, completion: @escaping (T) -> Void, errorHandler: @escaping (String) -> Void) {
        AF.request(api.endpoint, method: api.method, parameters: api.params).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print("response.response?.statusCode: \(response.response?.statusCode)")
                errorHandler(error.localizedDescription)
            }
        }
    }
}

