//
//  Date+Ext.swift
//  CaseStudy
//
//  Created by ARDA BUYUKHATIPOGLU on 12.01.2024.
//

import UIKit

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat        = "MMM yyyy"
        dateFormatter.locale            = Locale(identifier: "en_US_POSIX")
        
        return dateFormatter.string(from: self)
    }
}
