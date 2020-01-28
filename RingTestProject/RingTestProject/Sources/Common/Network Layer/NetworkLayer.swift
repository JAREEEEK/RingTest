//
//  NetworkLayer.swift
//  RingTestProject
//
//  Created by Yaroslav Nosik on 28.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.
//

import Foundation
import Combine

struct NetworkLayer {
    struct Response<T> {
        let value: T
        let response: URLResponse
    }

    private let logger = NetworkLogger()
    private let session = URLSession.shared


    func add<T: Decodable>(_ request: URLRequest,
                           _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, Error> {
        self.logger.logRequest(with: request)

        return session
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                self.logger.logResponse(data: result.data)

                let value = try decoder.decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
