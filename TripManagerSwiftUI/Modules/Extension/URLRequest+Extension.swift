//
//  URLRequest+Extension.swift
//  TripManagerSwiftUI
//
//  Created by Jonashio on 24/7/22.
//

import Foundation

extension URLRequest {
    // TODO: WHY NOT WORK?
    static var URL_BASE: String = "​https://europe-west1-metropolis-fe-test.cloudfunctions.net/"

    static func buildRequest(method: String, methodType: MethodType) -> URLRequest? {
        guard let url = URL(string: method) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = methodType.rawValue
        
        return request
    }
}
