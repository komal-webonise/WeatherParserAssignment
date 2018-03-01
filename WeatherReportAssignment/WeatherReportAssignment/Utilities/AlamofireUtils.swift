//
//  AlamofireUtils.swift
//  WeatherReportAssignment
//

import Foundation
import Alamofire

class AlamofireUtils {
    class var sharedInstance: AlamofireUtils {
        struct Static {
            static let instance = AlamofireUtils()
        }
        return Static.instance
    }
    
    func downloadFile(urlToBeDownloaded: String) -> Void {
        let fileUrl = CommonMethods.sharedInstance.getSaveFileUrl(
            fileName: urlToBeDownloaded)
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            return (fileUrl, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        Alamofire.download(urlToBeDownloaded, to:destination)
            .downloadProgress { (progress) in
                print("Progress: \(progress.fractionCompleted)")
            }
            .responseData { (data) in
                let documentsURL = FileManager.default.urls(for: .documentDirectory,
                                                            in: .userDomainMask)[0]
        
                let fileUrlOfCsv = documentsURL.appendingPathComponent(("weather.csv"))
                
                let headersOfReport = HeadersOfFile.REGION_CODE +
                                      Seperator.COMMA +
                                      HeadersOfFile.WEATHER_PARAM +
                                      Seperator.COMMA +
                                      HeadersOfFile.YEAR +
                                      Seperator.COMMA +
                                      HeadersOfFile.KEY +
                                      Seperator.COMMA +
                                      HeadersOfFile.VALUE +
                                      Seperator.NEWLINE
                do {
                    try headersOfReport.write(to: fileUrlOfCsv,
                                              atomically: true,
                                              encoding: String.Encoding.utf8)
                    print("done")
                } catch {
                    print("Failed ToCreate File")
                }
                do {
                    let dataOfDownloadedFile = try Data(contentsOf: fileUrl)
                    let attributedString = try NSAttributedString(data: dataOfDownloadedFile,
                                                                  documentAttributes: nil)
                    let contentOfFile = attributedString.string
                    let arrayOfLines = contentOfFile.components(separatedBy: Seperator.NEWLINE)
                    
                    var monthHeaders = [String]()
                    for line in arrayOfLines {
                        var lineNumber = 0
                        
                        let arrayOfTabspaceSeperatedData = line.components(separatedBy:
                                                           Seperator.TAB_SPACE)
                        if arrayOfTabspaceSeperatedData.count > 1 {
                            for dataElement in arrayOfTabspaceSeperatedData {
                                lineNumber += 1
                               let spaceSeperatedFilteredElement = dataElement.components(separatedBy:
                                Seperator.ONE_WHITESPACE).filter({$0 != Seperator.EMPTY_STRING})
                                var elementNumber = 0
                                var year = ""
                                for element in spaceSeperatedFilteredElement {
                                    if lineNumber == 1 {
                                        if !element.elementsEqual("Year") {
                                            monthHeaders.append(element)
                                            //elementNumber += 1
                                        }
                                    } else {
                                        
                                        
                                            let entry = "UK" +
                                                         Seperator.COMMA +
                                                         "Max temp" +
                                                          Seperator.COMMA +
                                                          "year" +
                                                          Seperator.COMMA +
                                                          "monthHeaders" +
                                                          Seperator.COMMA +
                                                          element +
                                                          Seperator.NEWLINE
                                            do {
                                                let fileHandle = try FileHandle(forWritingTo: fileUrlOfCsv)
                                                fileHandle.seekToEndOfFile()
                                                fileHandle.write(entry.data(using: .utf8)!)
                                                fileHandle.closeFile()
                            
                                                print("done")
                                            } catch {
                                                print("Failed ToCreate File")
                                            }
                                        
                                    }
                                    print(element)
                                }
                            }
                        }
                    }
                } catch {
                    print("Failed to add  File")
                }
                // print(response.destinationURL!.lastPathComponent)
        }
    }
}
