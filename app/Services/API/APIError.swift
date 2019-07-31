//
//  APIError.swift
//  ProjectName
//
//  Created by Your Name on 07/31/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

public enum APIError: Error {
    case tokenExpired
    case invalidCredentials
    case invalidResponse
    case server(statusCode: Int)
    case noData
}

public enum ProjectNameError: Error, Decodable {
    case unknown([String: Any])
    case example(ExampleError)

    enum CodingKeys: String, CodingKey {
        case errors
    }

    public enum ExampleError: String, Error, Decodable {
        case notFound = "Not found."
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let exampleError = try container.decode(ExampleError.self, forKey: .errors)
        self = .example(exampleError)
    }
}
