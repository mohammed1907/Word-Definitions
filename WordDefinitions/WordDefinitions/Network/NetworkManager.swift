//
//  NetworkManager.swift
//  WordDefinitions
//
//  Created by mohamed hassan on 14/02/2025.
//

import Foundation
import Moya
import CombineMoya
import Combine

protocol NetworkManagerProtocol {
    associatedtype API: TargetType
    func request<T: Decodable>(_ target: API) -> AnyPublisher<T, NetworkError>
}

class NetworkManager<API: TargetType>: NetworkManagerProtocol {
    private let provider: MoyaProvider<API>

    init(provider: MoyaProvider<API> = MoyaProvider<API>(plugins: [NetworkLoggerPlugin()])) {
        self.provider = provider
    }

    func request<T: Decodable>(_ target: API) -> AnyPublisher<T, NetworkError> {
        return provider.requestPublisher(target)
            .tryMap { response in
                return try self.parseResponse(response: response)
            }
            .mapError { error -> NetworkError in
                if let networkError = error as? NetworkError {
                    return networkError
                } else {
                    return .unknown
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    private func parseResponse<T: Decodable>(response: Response) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        do {
            if (200...299).contains(response.statusCode) {
                return try decoder.decode(T.self, from: response.data)
            } else {
                let error = try? decoder.decode(APIErrorResponse.self, from: response.data)
                throw error != nil ? NetworkError.apiError(message: error!.message) : NetworkError.unknown
            }
        } catch {
            throw NetworkError.decodingFailure
        }
    }
}
