//
//  File.swift
//  
//
//  Created by Kevin on 8/9/23.
//

import Foundation

public enum ApiError: Error {
    case requestFailed(description: String)
    case invalidData
    case responseUnsuccessful(description: String)
    case jsonConversionFailure(description: String)
    case jsonParsingFailure
    case failedSerialization
    case noInternet

    var customDescription: String {
        switch self {
        case let .requestFailed(description): return "Request Failed: \(description)"
        case .invalidData: return "Invalid Data)"
        case let .responseUnsuccessful(description): return "Unsuccessful: \(description)"
        case let .jsonConversionFailure(description): return "JSON Conversion Failure: \(description)"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .failedSerialization: return "Serialization failed."
        case .noInternet: return "No internet connection"
        }
    }
}

public protocol DBResponse {
    var data: Data { get }

}

public protocol DBServiceProtocol {
    func request<T: Codable>(_ apiRoutable: APIRoutable) async -> Result<T, ApiError>

    func request(apiRoutable: APIRoutable,completion: @escaping (Result<DBResponse, ApiError>) -> Void)
}

public extension DBServiceProtocol {
    func request<T: Codable>(_ apiRoutable: APIRoutable, type: T.Type) async -> Result<T, ApiError> {
        let urlRequest = URLRequest(url: apiRoutable.baseURl)
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw ApiError.invalidData
            }

            if httpResponse.statusCode == 200 {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return .success(decodedData)
            } else {
                throw ApiError.failedSerialization
            }
        } catch let error as ApiError {
            return .failure(error)
        } catch {
            return .failure(.invalidData)
        }
    }


}


public final class DBServiceImpl:  DBServiceProtocol {
    public func request(apiRoutable: APIRoutable, completion: @escaping (Result<DBResponse, ApiError>) -> Void) {

        
    }

    public init() {}
    
    public func request<T>(_ apiRoutable: APIRoutable) async -> Result<T, ApiError> where T : Decodable, T : Encodable {
        let urlRequest = URLRequest(url: apiRoutable.baseURl)
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw ApiError.invalidData
            }

            if httpResponse.statusCode == 200 {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return .success(decodedData)
            } else {
                throw ApiError.failedSerialization
            }
        } catch let eror  {
            return .failure(eror as! ApiError)
        }
    }

    public func request<T>(
        type: T.Type,
        _ apiRoutable: APIRoutable,
        completionHandler: @escaping (Result<T, ApiError>) -> Void
    ) where T:Codable {
        do {
            guard let urlRequest = try? URLRequest(url: apiRoutable.baseURl) else {
                completionHandler(.failure(.failedSerialization))
                return
            }
           URLSession.shared.dataTask(with: urlRequest) { data, resonse, error in

                guard let httpResponse = resonse as? HTTPURLResponse else {
                    completionHandler(.failure(.failedSerialization))
                    return
                }
                if httpResponse.statusCode == 200,
                   let data = data,
                   let decodedData = try? JSONDecoder().decode(T.self, from: data) {
                    completionHandler(.success(decodedData))
                } else {
                    completionHandler(.failure(.failedSerialization))
                }
            }.resume()

        } catch {
            completionHandler(.failure(.failedSerialization))
        }
    }

}

extension DBService {

    func request(_ apiRoutable: APIRoutable) async -> Result<DBResponse, ApiError> {
        await withCheckedContinuation({ continuation in
//            request(apiRoutable, completionhan)
        })
    }

}

