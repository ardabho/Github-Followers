//
//  String+Ext.swift
//  CaseStudy
//
//  Created by ARDA BUYUKHATIPOGLU on 12.01.2024.
//

import UIKit

extension String {
    
    func convertToDate() -> Date? {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale        = Locale(identifier: "en_US_POSIX")
        return dateFormatter.date(from: self)
    }
    
    
    func convertDateToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A" }
        return date.convertToMonthYearFormat()
    }
}
