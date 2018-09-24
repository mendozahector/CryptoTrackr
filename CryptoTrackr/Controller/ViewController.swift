//
//  ViewController.swift
//  CryptoTrackr
//
//  Created by Hector Mendoza on 9/24/18.
//  Copyright © 2018 Hector Mendoza. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var cryptoPicker: UIPickerView!
    
    let crytoData = CryptoData()
    var currencySymbol = ""
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/"
    
    var cryptoLabel = ""
    var currencyLabel = ""
    
    var finalURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cryptoPicker.delegate = self
        cryptoPicker.dataSource = self
    }
}




//MARK: - UIPickerView Methods
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return crytoData.numComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return crytoData.cryptoArray.count
        } else if component == 1 {
            return crytoData.currencyArray.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return crytoData.cryptoArray[row]
        } else if component == 1 {
            return crytoData.currencyArray[row]
        } else {
            return ""
        }
    }
}
