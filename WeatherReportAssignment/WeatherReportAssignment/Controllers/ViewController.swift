//
//  ViewController.swift
//  WeatherReportAssignment
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    //MARK: View cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AlamofireUtils.sharedInstance.downloadFile(urlToBeDownloaded: "https://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Tmax/date/UK.txt")
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

