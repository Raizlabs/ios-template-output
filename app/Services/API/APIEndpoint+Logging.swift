//
//  APIEndpoint+Logging.swift
//  ProjectName
//
//  Created by Your Name on 11/06/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import Swiftilities
import Alamofire

public class NetworkLog: Log {}

public protocol NetworkLoggable {

    var logLevel: Log.Level { get }

}

extension NetworkLoggable {

    public var logLevel: Log.Level {
        return .verbose
    }

}

extension APIEndpoint {

    func log(_ request: DataRequest) {
        log(request.debugDescription)
    }

    func log(_ any: Any) {
        switch logLevel {
        case .verbose: NetworkLog.verbose(any)
        case .debug: NetworkLog.debug(any)
        case .info: NetworkLog.info(any)
        case .warn: NetworkLog.warn(any)
        case .error: NetworkLog.error(any)
        case .off: break
        }
    }

}
