//
//  NetworkUtils.swift
//  TripManagerSwiftUI
//
//  Created by Jonashio on 24/7/22.
//

import Foundation

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

public typealias NTResponse<Value> = ((NTResult<Value, NTError<Error>>) -> Void)
public typealias NTParams = [String: String]

protocol CommonDataSourceProtocol {
    func fetchRequest<T:Codable>(params: NTParams, completion: @escaping NTResponse<T>)
}
