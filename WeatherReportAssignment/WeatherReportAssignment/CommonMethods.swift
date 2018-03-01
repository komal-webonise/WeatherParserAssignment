//
//  CommonMethods.swift
//  WeatherReportAssignment
//

import Foundation

class CommonMethods {
    class var sharedInstance: CommonMethods {
        struct Static {
            static let instance = CommonMethods()
        }
        return Static.instance
    }
    
    func getSaveFileUrl(fileName: String) -> URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory,
                                                    in: .userDomainMask)[0]
        let nameUrl = URL(string: fileName)
        let fileURL = documentsURL.appendingPathComponent((nameUrl?.lastPathComponent)!)
        return fileURL
    }
}
