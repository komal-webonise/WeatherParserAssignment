//
//  Constants.swift
//  WeatherReportAssignment

import Foundation

typealias ApiUrl = Constants.ApiUrl
typealias HeadersOfFile = Constants.HeadersOfFile
typealias Seperator = Constants.Seperator

class Constants {
    class ApiUrl {
        static let BASE_URL = "https://www.metoffice.gov.uk/pub/data/weather/"
    }
    
    class HeadersOfFile {
        static let REGION_CODE = "region_code"
        static let WEATHER_PARAM = "weather_param"
        static let YEAR = "year"
        static let KEY = "key"
        static let VALUE = "value"
    }
    
    class Seperator {
        static let COMMA = ","
        static let NEWLINE = "\n"
        static let TAB_SPACE = "    "
        static let ONE_WHITESPACE = " "
        static let EMPTY_STRING = ""
    }
}
