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
    
    @IBOutlet weak var cryptoLabelView: UILabel!
    @IBOutlet weak var cryptoImageVIew: UIImageView!
    
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
    
    
    //MARK: - UIPickerDeletage Method
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            cryptoLabel = crytoData.cryptoArray[row]
        } else if component == 1 {
            currencyLabel = crytoData.currencyArray[row]
            currencySymbol = crytoData.currencySymbolArray[row]
        }
        
        if !cryptoLabel.isEmpty && !currencyLabel.isEmpty {
            finalURL = baseURL + cryptoLabel + currencyLabel
            getCryptoData(url: finalURL)
        } else {
            //One component missing selection
        }
    }
    
    //MARK: - Networking
    func getCryptoData(url: String) {
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {
                    let cryptoJSON : JSON = JSON(response.result.value!)
                    self.updateCryptoData(json: cryptoJSON)
                    self.updateUILabels()
                } else {
                    self.priceLabel.text = "Connection Issues"
                }
        }
    }
    
    
    //MARK: - JSON Parsing
    func updateCryptoData(json : JSON) {
        if let cryptoPrice = json["ask"].double {
            priceLabel.text = currencySymbol + String(format: "%.2f", cryptoPrice)
        } else {
            priceLabel.text = "Price Unavailable"
        }
    }
    
    
    //MARK: - Updating UI Labels
    func updateUILabels() {
        var name: String = ""
        var image: String = ""
        
        switch cryptoLabel {
        case "BTC":
            name = "Bitcoin"
            image = "bitcoinicon"
        case "LTC":
            name = "Litecoin"
            image = "litecoinicon"
        case "ETH":
            name = "Ethereum"
            image = "ethereumicon"
        case "ZEC":
            name = "ZCash"
            image = "zcashicon"
        case "XRP":
            name = "Ripple"
            image = "rippleicon"
        case "XMR":
            name = "Monero"
            image = "moneroicon"
        default:
            name = ""
            image = ""
        }
        
        cryptoImageVIew.image = UIImage(named: image)
        cryptoLabelView.text = name
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
