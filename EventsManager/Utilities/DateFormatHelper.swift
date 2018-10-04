//
//  DateFormatHelper.swift
//  EventsManager
//
//  Created by Ethan Hu on 4/10/18.
//
//

import Foundation

class DateFormatHelper {
    private static let datetimeFromStringFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            formatter.timeZone = TimeZone(abbreviation: "EST")
            return formatter
    }()

    private static let hourMinuteFromDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "h:mm a"
        formatter.timeZone = TimeZone(abbreviation: "EST")
        return formatter
    }()

    private static let monthFromDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "MMM"
        formatter.timeZone = TimeZone(abbreviation: "EST")
        return formatter
    }()

    private static let dayFromDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd"
        formatter.timeZone = TimeZone(abbreviation: "EST")
        return formatter
    }()

    private static let dateFromStringFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(abbreviation: "EST")
        return formatter
    }()

    public static func datetime(from string: String) -> Date? {
        return datetimeFromStringFormatter.date(from: string)
    }
    public static func datetime(from date: Date) -> String {
        return datetimeFromStringFormatter.string(from: date)
    }
    public static func date(from string: String) -> Date? {
        return dateFromStringFormatter.date(from: string)
    }
    public static func date(from date: Date) -> String {
        return dateFromStringFormatter.string(from: date)
    }
    public static func hourMinute(from date: Date) -> String {
        return hourMinuteFromDateFormatter.string(from: date)
    }
    public static func month(from date: Date) -> String {
        return monthFromDateFormatter.string(from: date)
    }
    public static func day(from date: Date) -> String {
        return dayFromDateFormatter.string(from: date)
    }
    public static func dayAbbreviationOfWeek(from date: Date) -> String {
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: date)
        switch weekDay {
            case 1: return NSLocalizedString("date-format-week-day-abbr-mon", comment: "")
            case 2: return NSLocalizedString("date-format-week-day-abbr-tue", comment: "")
            case 3: return NSLocalizedString("date-format-week-day-abbr-wed", comment: "")
            case 4: return NSLocalizedString("date-format-week-day-abbr-thu", comment: "")
            case 5: return NSLocalizedString("date-format-week-day-abbr-fri", comment: "")
            case 6: return NSLocalizedString("date-format-week-day-abbr-sat", comment: "")
            case 7: return NSLocalizedString("date-format-week-day-abbr-sun", comment: "")
            default: return "ERR"
        }
    }

    public static func dayOfWeek(from date: Date) -> String {
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: date)
        switch weekDay {
            case 1: return NSLocalizedString("date-format-week-day-full-mon", comment: "")
            case 2: return NSLocalizedString("date-format-week-day-full-tue", comment: "")
            case 3: return NSLocalizedString("date-format-week-day-full-wed", comment: "")
            case 4: return NSLocalizedString("date-format-week-day-full-thu", comment: "")
            case 5: return NSLocalizedString("date-format-week-day-full-fri", comment: "")
            case 6: return NSLocalizedString("date-format-week-day-full-sat", comment: "")
            case 7: return NSLocalizedString("date-format-week-day-full-sun", comment: "")
            default: return "ERR"
        }
    }

}
