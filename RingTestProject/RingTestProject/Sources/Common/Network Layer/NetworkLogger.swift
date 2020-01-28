//
//  NetworkLogger.swift
//  RingTestProject
//
//  Created by Yaroslav Nosik on 28.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.
//

import Foundation

struct NetworkLogger {
    func logRequest(with request: URLRequest) {
        #if DEBUG
        print("\n - - - - - - - - - - Request - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        #endif

        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)

        let method = request.httpMethod ?? ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"

        var logOutput = """
        \(urlAsString) \n\n
        \(method) \(path)?\(query) \n
        HOST: \(host)\n
        """
        for (key, value) in request.allHTTPHeaderFields ?? [: ] {
            logOutput += "\(key): \(value) \n"
        }
        if let body = request.httpBody {
            logOutput += "\n \(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "")"
        }

        #if DEBUG
        print(logOutput)
        #endif
    }

    func logResponse(data: Data) {
        #if DEBUG
        print("\n - - - - - - - - - - Response - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        #endif

        guard let object = try? JSONSerialization.jsonObject(with: data, options: []),
            let serializedData = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let prettyPrintedString = NSString(data: serializedData,
                                               encoding: String.Encoding.utf8.rawValue) else { return }
        #if DEBUG
        print(prettyPrintedString)
        #endif
    }
}
