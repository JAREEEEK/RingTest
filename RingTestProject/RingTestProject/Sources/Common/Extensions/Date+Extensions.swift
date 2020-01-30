//
//  Date+Extensions.swift
//  RingTestProject
//
//  Created by Yaroslav Nosik on 29.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.
//

import Foundation

extension Date {
    func getDiffStringTime() -> String {
        let parts: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let diff = NSCalendar.current.dateComponents(parts, from: self, to: Date())

        if let year = diff.year, year != 0 {
            return year >= 2 ? "\(year) years ago" : "Last year"
        } else if let month = diff.month, month != 0 {
            return month >= 2 ? "\(month) months ago" : "Last month"
        } else if let weekOfYear = diff.weekOfYear, weekOfYear != 0 {
            return weekOfYear >= 2 ? "\(weekOfYear) weeks ago" : "Last week"
        } else if let day = diff.day, day != 0 {
            return day >= 2 ? "\(day) days ago" : "Yesterday"
        } else if let hour = diff.hour, hour != 0 {
            return hour >= 2 ? "\(hour) hours ago" : "An hour ago"
        } else if let minute = diff.minute, minute != 0 {
            return minute >= 2 ? "\(minute) minutes ago" : "A minute ago"
        } else if let second = diff.second, second >= 3  {
            return "\(second) seconds ago"
        } else {
            return "Just now"
        }
    }
}
