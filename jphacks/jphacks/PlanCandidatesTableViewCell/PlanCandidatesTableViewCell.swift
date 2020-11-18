//
//  PlanCandidatesTableViewCell.swift
//  jphacks
//
//  Created by 寺尾京芽 on 2019/10/25.
//  Copyright © 2019 山下陽央. All rights reserved.
//

import UIKit

class PlanCandidatesTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(indexPath: IndexPath) {
        let info = TripInfoRepository().findInfo()[indexPath.row]
        var hotelmage: UIImage? {
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

        airportLabel.text = info.AirPortName
        hotelLabel.text = info.hotelname
        departTimeLabel.text = info.ForwardAirDepartTime
        arriveTimeLabel.text = info.ForwardAirArriveTime
        priceLabel.text = info.ForwardAirTicketPrice
        
        reviewQuantityLabel.text = info.hotelReviewNum
        reviewQualityLabel.text = info.hotelReviewRate
        hotelImageView.image = hotelmage
    }
    
    @IBOutlet weak var airportLabel: UILabel!
    @IBOutlet weak var hotelLabel: UILabel!

    @IBOutlet weak var departTimeLabel: UILabel!
    @IBOutlet weak var arriveTimeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var reviewQuantityLabel: UILabel!
    @IBOutlet weak var reviewQualityLabel: UILabel!
    
    @IBOutlet weak var hotelImageView: UIImageView!
}
