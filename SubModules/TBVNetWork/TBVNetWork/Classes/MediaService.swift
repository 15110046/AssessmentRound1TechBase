//
//  MediaService.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 28/04/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import Alamofire
import Alamofire_SwiftyJSON
import SwiftyJSON

public struct Response<T> {
    
    public enum Status {
        case failure(String)
        case success(_ result: T)
    }
    
    public var status: Status = .failure("Unknown Error")
    
    public init(status: Status) {
        self.status = status
    }
}

open class MediaService: NSObject {
    public static var share: MediaService = MediaService()
    
    public func fetchData(page: Int, limit: Int, completion: @escaping (DataResponse<JSON>) -> ()) {
        let url = "https://picsum.photos/v2/list?page=\(page)&limit=\(limit)"
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default).responseSwiftyJSON { (response) in
            completion(response)
        }
    }
}
