//
//  Service.swift
//  Memories
//
//  Created by Naomi Schettini on 5/30/21.
//

import Foundation
import Combine
import Alamofire

enum ServiceError: Error {
    case statusCode
    case decoding
    
    case other(Error)
    
    static func map(_ error: Error) -> ServiceError {
        return (error as? ServiceError) ?? .other(error)
    }
}

class Service: ObservableObject {
    
    private let url = "https://jsonplaceholder.typicode.com/photos"
    
    @Published var albums = [Album]()
    
    init() {
        getAlbums()
    }
    
    func getAlbums() {
        AF.request(url)
            .responseJSON { response in
                switch response.result {
                case .success(let encodedAlbums):
                    guard let albumData = encodedAlbums as? Data else { return }
                    let albums: [Album] =  try! JSONDecoder().decode([Album].self,
                                                                     from: albumData)
                    print(albums)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
