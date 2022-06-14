//
//  WMApiClient.swift
//  WM-Viper
//
//  Created by Fong Zhou on 14/06/2022.
//

import Foundation

import Alamofire

 public protocol NetworkClient {
     func request<T: Decodable>(with url: URL) async throws -> T
 }

 public final class DefaultNetworkClient: NetworkClient {

     private let sessionManager: Session = Session.default

     public init() { }

     public func request<T: Decodable>(with url: URL) async throws -> T {
         let headers = HTTPHeaders(["Accept-Version": "V1"])
         let parameters: [String: String] = ["client_id": "1FQZOVdGqYe64BO9ZUKOj_N2z3kafPTZRXwGIRHgIHA"]
         let task = sessionManager.request(
            url,
             method: .get,
             parameters: parameters,
             headers: headers,
             interceptor: nil
         ).serializingDecodable(T.self, decoder: JSONDecoder())
         return try await task.value
     }

 }
