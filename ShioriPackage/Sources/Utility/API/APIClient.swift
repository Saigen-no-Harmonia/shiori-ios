//
//  APIClient.swift
//  ShioriPackage
//
//  Created by canacel on 2025/08/24.
//

import ComposableArchitecture
import Foundation
import OSLog

public struct APIClient: Sendable {
  public var request: @Sendable (_ request: any ShioriRequestProtocol) async throws -> Data
  
  public func request<T: ShioriRequestProtocol>(_ request: T) async throws -> T.Response {
    let data = try await self.request(request)
    do {
      let jsonDecoder = JSONDecoder()
      jsonDecoder.dateDecodingStrategy = .iso8601
      return try jsonDecoder.decode(T.Response.self, from: data)
    } catch {
      print(error)
      Logger.standard.debug("decodingError")
      throw APIError.decodingError
    }
  }
}

extension APIClient: DependencyKey {
  public static let liveValue = Self(
    request: { shioriRequest in
      let config = URLSessionConfiguration.default
      config.timeoutIntervalForRequest = 10
      config.timeoutIntervalForResource = 10
      let session = URLSession(configuration: config)
      
      let baseURL = await MainActor.run {
        CREDENTIALS.shared["API_BASE_URL"] as! String
      }
      guard let url = URL(string: baseURL + shioriRequest.path.rawValue) else {
        Logger.standard.debug("invalidURL")
        throw APIError.invalidURL
      }
      
      var request = URLRequest(url: url)
      request.httpMethod = shioriRequest.method.rawValue
      
      shioriRequest.headers?.forEach { key, value in
        request.setValue(value, forHTTPHeaderField: key)
      }
      
      let apiKey = await MainActor.run {
        CREDENTIALS.shared["API_KEY"] as! String
      }
      request.setValue(apiKey, forHTTPHeaderField: "X-Api-Token")
      
      if let body = shioriRequest.body {
        request.httpBody = body
      }
      
      do {
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
          Logger.standard.debug("networkError")
          throw APIError.networkError(URLError(.badServerResponse))
        }
        
        guard 200...299 ~= httpResponse.statusCode else {
          Logger.standard.debug("httpError \(httpResponse.statusCode)")
          throw APIError.httpError(httpResponse.statusCode)
        }
        
        return data
        
      } catch {
        throw APIError.networkError(error)
      }
    }
  )
  
  public static let testValue = Self(request: { _ in Data() })
}

extension DependencyValues {
  public var apiClient: APIClient {
    get { self[APIClient.self] }
    set { self[APIClient.self] = newValue }
  }
}
