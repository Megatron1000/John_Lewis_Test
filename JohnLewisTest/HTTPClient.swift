//
//  HTTPClient.swift
//  NetAborter
//
//  Created by Mark Bridges on 24/11/2016.
//  Copyright © 2016 BridgeTech. All rights reserved.
//

import Foundation

class HTTPClient {

    // MARK: Result enum

    enum HTTPClientResult {
        case success(data: Data?)
        case failure(error: Error)
    }

    // MARK: Properties

    let session: NetworkSession

    // MARK: Initialisation

    required init(session: NetworkSession = URLSession(configuration: URLSessionConfiguration.default)) {
        self.session = session
    }

    // MARK: Network call

    func makeNetworkRequest(with url: URL, completion: @escaping ((HTTPClientResult) -> Void)) {

        session.startDataTask(with: url, completionHandler: { (data, _, error) -> Void in

            if let error = error {
                completion(.failure(error: error))
                return
            }

            completion(.success(data: data))
        })
    }
}

// MARK: NetworkSession protocol - (To aid in testing we don't use a URLSession directly, but instead a NetworkSession protocol)

protocol NetworkSession {
    func startDataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void)
}

// MARK: URLSession NetworkSession Conformance

extension URLSession: NetworkSession {

    func startDataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
        let dataTask = self.dataTask(with: url, completionHandler: completionHandler)
        dataTask.resume()
    }
}
