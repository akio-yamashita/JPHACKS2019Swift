//
//  Calendar+Extension.swift
//  jphacks
//
//  Created by 山下陽央 on 2019/10/26.
//  Copyright © 2019 山下陽央. All rights reserved.
//

import Foundation

extension Calendar {
    func yearMonthDate(for date:Date) -> Date {
        let comps = self.dateComponents([.year, .month, .day], from: date)
        return self.date(from: comps)!
    }
}
