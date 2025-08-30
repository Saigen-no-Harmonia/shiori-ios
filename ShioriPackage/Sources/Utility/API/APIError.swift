//
//  APIError.swift
//  ShioriPackage
//
//  Created by canacel on 2025/08/24.
//

enum APIError: Error {
  case invalidURL
  case noData
  case decodingError
  case httpError(Int)
  case networkError(Error)
}
