//
//  TripInfoClient.swift
//  jphacks
//
//  Created by 山下陽央 on 2019/10/25.
//  Copyright © 2019 山下陽央. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct TripInfoPostClient {
    static func post(depPlace: String,
                     budget: String,
                     retDate: String,
                     people: String,
                     completionHandler: @escaping () -> Void,
                     errorHandler: @escaping () -> Void) {
        let api: TripInfoPostApi = .post(depPlace: depPlace, budget: budget, retDate: retDate, people: people)
        let (url, method, headers, params) = api.alamofireParams
        Alamofire.request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success:
                    completionHandler()
                    
                case .failure(let error):
                    print(error)
                    errorHandler()
                }
        }
    }
}

struct TripGetPostClient {
    static func get(completionHandler: @escaping () -> Void, errorHandler: @escaping () -> Void) {
        let api: TripInfoGetApi = .get
        let (url, method, headers, params) = api.alamofireParams
        
        Alamofire.request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(let responseData):
                    let json = JSON(responseData)
                    let objects = TripInfo.parse(json: json)
                    TripInfoRepository().save(objects)
                    
                    completionHandler()
                    
                case .failure(let error):
                    print(error)
                    errorHandler()
                }
        }
    }
}
