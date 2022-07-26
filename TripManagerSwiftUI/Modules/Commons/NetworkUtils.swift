//
//  NetworkUtils.swift
//  TripManagerSwiftUI
//
//  Created by Jonashio on 24/7/22.
//

import Foundation
import SwiftUI

public enum NTError<U> {
    case emptyData
    case serverFailure(U?)
    case businessFailure
    case unknown
}

public enum NTResult<T, U> {
    case success(T)
    case error(U)
}

public typealias NTParams = [String: String]
public typealias NTResponse<Value> = ((NTResult<Value, NTError<Error>>) -> Void)

public enum MethodType: String {
    case GET
    case HEAD
    case POST
    case PUT
    case DELETE
}
