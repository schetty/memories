//
//  Service.swift
//  Memories
//
//  Created by Naomi Schettini on 5/30/21.
//

import Foundation
import Combine

enum ServiceError: Error {
  case statusCode
  case decoding

  case other(Error)
  
  static func map(_ error: Error) -> ServiceError {
    return (error as? ServiceError) ?? .other(error)
  }
}

class Service: NSObject {
    
    static func randomImage() -> AnyPublisher<Album, ServiceError> {
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")!
        
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        let session = URLSession(configuration: config)

        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Accept-Version", forHTTPHeaderField: "v1")
        return session.dataTaskPublisher(for: urlRequest)
          .tryMap { response -> Data in
            guard
              let httpURLResponse = response.response as? HTTPURLResponse,
              httpURLResponse.statusCode == 200
              else {
                throw ServiceError.statusCode
            }
            return response.data
          }
          .decode(type: Album.self, decoder: JSONDecoder())
          .mapError { ServiceError.map($0) }
          .eraseToAnyPublisher()
    }
}
