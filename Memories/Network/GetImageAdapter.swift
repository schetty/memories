//
//  GetImageAdapter.swift
//  Memories
//
//  Created by Naomi Schettini on 5/31/21.
//

import Foundation
import Alamofire

final class GetImageAdapter {
    
    static func getImage(from url: String, completion: @escaping (UIImage) -> Void) {
        AF.request(url)
            .response { response in
                switch response.result {
                case .success:
                    guard let data = response.data,
                          let image = UIImage(data: data, scale: 1) else { return }
                    completion(image)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
