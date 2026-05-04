//
//  AppConfiguration.swift
//  TheGoodCorner
//
//  Created by Sofienne Trimech on 04/05/2026.
//

import Foundation

/// Defines the current execution environment.
enum Environment {
    case development
    case production

    var baseURL: URL {
        switch self {
        case .development:
            return URL(string: "http://localhost:8080")!
        case .production:
            return URL(string: "https://api.thegoodcorner.com")!
        }
    }
}

/// Centralized application configuration.
///
/// Uses Swift compiler flags to determine the environment,
/// avoiding storing URLs or sensitive keys in `Info.plist`.
enum AppConfiguration {

    #if DEBUG
    static let environment: Environment = .development
    #else
    static let environment: Environment = .production
    #endif

    /// The base URL for the API, configured by the current environment.
    static var baseURL: URL {
        return environment.baseURL
    }
}
