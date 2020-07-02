//
//  Date.swift
//  ExpenseApp
//
//  Created by Praval Telagi on 7/2/20.
//  Copyright © 2020 Ansh Bhalla. All rights reserved.
//

import Foundation


struct DateFunctions {
    
    static func GetTodaysDate() -> String {
        let formatter : DateFormatter = DateFormatter()
        formatter.dateFormat = "M/d/yyyy"
        let today : String = formatter.string(from:   NSDate.init(timeIntervalSinceNow: 0) as Date)
        print(today)
        return today
    }
    
    static func GetCurrentMonthAndYear() -> String {
        let formatter : DateFormatter = DateFormatter()
        formatter.dateFormat = "M/yyyy"
        let todayMonthYear : String = formatter.string(from:   NSDate.init(timeIntervalSinceNow: 0) as Date)
        return todayMonthYear
    }
    
    static func FullDateToMonthYear(dateToFormat: String) -> String {
        let isoDate = dateToFormat
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "M/dd/yyyy"
        let newDate = dateFormatter.date(from:isoDate)!
        
        let formatter : DateFormatter = DateFormatter()
        formatter.dateFormat = "M/yyyy"
        let newDateFormat : String = formatter.string(from: newDate)
        return newDateFormat
    }
    
    static func ConvertStringToDate(date: String) -> Date {
        let isoDate = date
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "M/d/yyyy"
        let newDate = dateFormatter.date(from:isoDate)!
        return newDate
    }
    
    static func isEqual(to date: Date, toGranularity component: Calendar.Component, in calendar: Calendar = .current) -> Bool {
        return calendar.isDate(Date(), equalTo: date, toGranularity: component)
    }
    
    static func isInSameWeek(as date: Date) -> Bool {
        return isEqual(to: date, toGranularity: .weekOfYear)
    }
    
    static func GetDateMonth(date: String) -> String {
        let isoDate = date
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "M/yyyy"
        let newDate = dateFormatter.date(from:isoDate)!
        
        let formatter : DateFormatter = DateFormatter()
        formatter.dateFormat = "M"
        let newMonth : String = formatter.string(from: newDate)
        return newMonth
    }
    
    static func GetDateYear(date:String) -> String {
        
        let isoDate = date
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy"
        let newDate = dateFormatter.date(from:isoDate)!
        let newYear = "\(newDate)"
        return newYear
    }
    
    static func GetCurrentYear() -> String {
        let formatter : DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let todayYear : String = formatter.string(from:   NSDate.init(timeIntervalSinceNow: 0) as Date)
        return todayYear
    }
    
    static func GetCurrentMonth() -> String {
        let formatter : DateFormatter = DateFormatter()
        formatter.dateFormat = "M"
        let todayMonth : String = formatter.string(from:   NSDate.init(timeIntervalSinceNow: 0) as Date)
        return todayMonth
    }
    
}
