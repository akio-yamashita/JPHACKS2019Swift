//
//  routeViewController.swift
//  jphacks
//
//  Created by 寺尾京芽 on 2019/10/26.
//  Copyright © 2019 山下陽央. All rights reserved.
//

import UIKit

class RouteViewController: UIViewController {
    let info: TripInfo
    
    init(indexPath: IndexPath) {
        self.info = TripInfoRepository().findInfo()[indexPath.row]

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        airportALabel.text = InitialInfo.shared.airportName
        airportBLabel.text = info.AirPortName
        timeALabel.text = info.ForwardAirDepartTime
        timeBLabel.text = info.ForwardAirArriveTime
        
        
        flightNoLabel.text = info.ReturnAirCandidate1
        
        
        hotelImageView.image = hotelmage
        rateLabel.text = info.hotelReviewRate
        reviewCountLabel.text = info.hotelReviewNum
        
        returnDateLabel.text = InitialInfo.shared.returnDate
        
        returnDepartTime1Label.text = info.ReturnAirDepartTime1
        returnDepartTime2Label.text = info.ReturnAirDepartTime2
        returnDepartTime3Label.text = info.ReturnAirDepartTime3
        
        returnArriveTime1Label.text = info.ReturnAirArriveTime1
        returnArriveTime2Label.text = info.ReturnAirArriveTime2
        returnArriveTime3Label.text = info.ReturnAirArriveTime3
        
        returnAir1Label.text = info.ReturnAirCandidate1
        returnAir2Label.text = info.ReturnAirCandidate2
        returnAir3Label.text = info.ReturnAirCandidate3
        
        price1Label.text = info.ReturnAirTicketPrice1
        price2Label.text = info.ReturnAirTicketPrice2
        price3Label.text = info.ReturnAirTicketPrice3
        
        hotelNameLabel.text = info.hotelname
    }
    
    private var hotelmage: UIImage? {
        if let imageUrl = info.hotelImage {
            do {
                let data = try Data(contentsOf: imageUrl)
                return UIImage(data: data)
            } catch {
                fatalError()
            }
        } else {
            return nil
        }
    }
    
    @IBOutlet weak var airportALabel: UILabel!
    @IBOutlet weak var airportBLabel: UILabel!
    @IBOutlet weak var timeALabel: UILabel!
    @IBOutlet weak var timeBLabel: UILabel!
    @IBOutlet weak var flightNoLabel: UILabel!
    @IBOutlet weak var hotelImageView: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var returnDateLabel: UILabel!
    
    @IBOutlet weak var returnTripInfoStackView: UIStackView! 
    
    @IBOutlet weak var returnDepartTime1Label: UILabel!
    @IBOutlet weak var returnDepartTime2Label: UILabel!
    @IBOutlet weak var returnDepartTime3Label: UILabel!
    @IBOutlet weak var returnArriveTime1Label: UILabel!
    @IBOutlet weak var returnArriveTime2Label: UILabel!
    @IBOutlet weak var returnArriveTime3Label: UILabel!
    @IBOutlet weak var returnAir1Label: UILabel!
    @IBOutlet weak var returnAir2Label: UILabel!
    @IBOutlet weak var returnAir3Label: UILabel!

    @IBOutlet weak var price1Label: UILabel!
    @IBOutlet weak var price2Label: UILabel!
    @IBOutlet weak var price3Label: UILabel!
    
    @IBAction func didTapOpenMapButton(_ sender: Any) {
        let gLatitude = info.AirportLatitude
        let gLongitude = info.AirportLongtitude
        let sLatitude = info.hotelLatitude
        let sLongitude = info.hotelLongtitude
        
        let urlString = "http://maps.apple.com/?daddr=\(gLatitude),\(gLongitude)&saddr=\(sLatitude),\(sLongitude)&dirflg=r"
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBOutlet weak var hotelNameLabel: UILabel!
    
    @IBAction func didTapDetailButton(_ sender: Any) {
        if let url = info.hotelDetail,
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
