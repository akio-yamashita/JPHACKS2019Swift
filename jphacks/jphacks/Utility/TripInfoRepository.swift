//
//  TripInfoRepository.swift
//  jphacks
//
//  Created by 山下陽央 on 2019/10/27.
//  Copyright © 2019 山下陽央. All rights reserved.
//

import Foundation
import SwiftyJSON

struct TripInfoRepository {
    func findInfo() -> [TripInfo] {
        return TripInfoCache.shared.info
    }
    
    func save(_ info: [TripInfo]) {
        TripInfoCache.shared.info = info
    }
}

class TripInfoCache {
    static let shared = TripInfoCache()
    private init() {}
    var info: [TripInfo] = []
}

class TripInfo {
    let hotelname: String
    let hotelLatitude: String
    let hotelLongtitude: String
    let hotelReviewNum: String
    let hotelReviewRate: String
    let hotelDetail: URL?
    
    let hotelImage: URL?
    let AirPortName: String
    let AirportLatitude: String
    let AirportLongtitude: String
    
    let ForwardAirTicketPrice: String
    let ForwardAirDepartTime: String
    let ForwardAirArriveTime: String
    
    let ReturnAirTicketPrice1: String
    let ReturnAirTicketPrice2: String
    let ReturnAirTicketPrice3: String
    
    let ReturnAirCandidate1: String
    let ReturnAirCandidate2: String
    let ReturnAirCandidate3: String
    
    let ReturnAirDepartTime1: String
    let ReturnAirArriveTime1: String
    let ReturnAirDepartTime2: String
    let ReturnAirArriveTime2: String
    let ReturnAirDepartTime3: String
    let ReturnAirArriveTime3: String
    
    init(json: JSON) {
        hotelname = json["hotelname"].stringValue
        hotelLatitude = json["hotel_latitude"].stringValue
        hotelLongtitude = json["hotel_longtitude"].stringValue
        hotelReviewNum = json["hotel_review_num"].stringValue
        hotelReviewRate = json["hotel_review_rate"].stringValue
        
        hotelDetail = json["hotel_detail"].url
        hotelImage = json["hotel_image"].url
        AirPortName = json["AirPortname"].stringValue
        AirportLatitude = json["Airport_latitude"].stringValue
        AirportLongtitude = json["Airport_longtitude"].stringValue
        
        ForwardAirTicketPrice = json["ForwardAir_ticket_price"].stringValue
        ForwardAirDepartTime = json["ForwardAir_depart_time"].stringValue
        ForwardAirArriveTime = json["ForwardAir_arrive_time"].stringValue
        
        ReturnAirTicketPrice1 = json["ReturnAir_ticket_price1"].stringValue
        ReturnAirTicketPrice2 = json["ReturnAir_ticket_price2"].stringValue
        ReturnAirTicketPrice3 = json["ReturnAir_ticket_price3"].stringValue
        
        ReturnAirCandidate1 = json["ReturnAir_candidate_1"].stringValue
        ReturnAirCandidate2 = json["ReturnAir_candidate_2"].stringValue
        ReturnAirCandidate3 = json["ReturnAir_candidate_3"].stringValue
        
        ReturnAirDepartTime1 = json["ReturnAir_depart_time1"].stringValue
        ReturnAirArriveTime1 = json["ReturnAir_arrive_time1"].stringValue
        ReturnAirDepartTime2 = json["ReturnAir_depart_time2"].stringValue
        ReturnAirArriveTime2 = json["ReturnAir_arrive_time2"].stringValue
        ReturnAirDepartTime3 = json["ReturnAir_depart_time3"].stringValue
        ReturnAirArriveTime3 = json["ReturnAir_arrive_time3"].stringValue
    }
}

extension TripInfo {
    static func parse(json: JSON) -> [TripInfo] {
        let jsons = json.dictionaryValue
        return jsons.map({ TripInfo(json: $0.value) })
    }
}

class InitialInfo {
    static let shared = InitialInfo()
    private init() {}
    var airportName: String = ""
    var returnDate: String = ""
}
