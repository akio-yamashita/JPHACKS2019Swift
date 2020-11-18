//
//  TripInfoApi.swift
//  jphacks
//
//  Created by 山下陽央 on 2019/10/25.
//  Copyright © 2019 山下陽央. All rights reserved.
//

import Foundation
import Alamofire

enum Constant {
    static let postUrl = "https://jphacks-2cd97.firebaseio.com/req.json"
    static let getUrl = "https://jphacks-2cd97.firebaseio.com/resultdata.json"
}

enum TripInfoPostApi {
    var baseURL: String {
        return Constant.postUrl
    }
    case post(depPlace: String, budget: String, retDate: String, people: String)
}

extension TripInfoPostApi {
    var headers: [String: String]? {
        switch self {
        case .post:
            return nil
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .post:
            return .patch
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .post(let depPlace, let budget, let retDate, let people):
            var params = [String: Any]()
            params["req_ID"] = NSUUID().uuidString
            params["dep_place"] = depPlace
            params["ret_date"] = retDate
            params["budget"] = budget
            params["people"] = people
            return params
        }
    }
    
    var alamofireParams: (url: String, method: Alamofire.HTTPMethod, headers: [String: String]?, params: [String: Any]?) {
        let url = baseURL
        return (url: url, method: method, headers: headers, params: parameters)
    }
}

enum TripInfoGetApi {
    var baseURL: String {
        return Constant.getUrl
    }
    case get
}

extension TripInfoGetApi {
    var headers: [String: String]? {
        switch self {
        case .get:
            return nil
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .get:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .get:
            return nil
        }
    }
    
    var alamofireParams: (url: String, method: Alamofire.HTTPMethod, headers: [String: String]?, params: [String: Any]?) {
        let url = baseURL
        return (url: url, method: method, headers: headers, params: parameters)
    }
}

