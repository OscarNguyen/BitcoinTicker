//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Angela Yu on 23/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate {
    
    
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    let logoArray = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    var finalURL = ""
    var selectedSymbol=""

    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate = self;
        currencyPicker.dataSource = self;
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    
    //TODO: Place your 3 UIPickerView delegate methods here
   
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(currencyArray[row])
        finalURL = baseURL+currencyArray[row]
        print(finalURL)
        selectedSymbol = logoArray[row]
      //  bitcoinPriceLabel.text = logoArray[row] + finalURL
       getBtcData(url: finalURL)
        
       
        
        
    }
    
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    func getBtcData(url: String){
       
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {

                    
                    let btcJSON : JSON = JSON(response.result.value!)

                  self.updateBtcData(json: btcJSON)
                    

                } else {
                    print("Error: \(String(describing: response.result.error))")
                    self.bitcoinPriceLabel.text = "Lỗi mạng cmnr bạn!"
                }
            }

    }

    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    func updateBtcData(json : JSON) {
        
      // var i : Int;
        
        if let btcResult = json["averages"]["day"].double {
            
//            for i in stride(from:0, through: currencyArray.count-1, by: 1){
//                for i in stride(from:0, through: logoArray.count-1, by: 1){
            //for i in stride(from: 0, to: logoArray.count-1, by: 1){
          //  bitcoinPriceLabel.text = logoArray[i] + String(btcResult)
            
            
            
            //for i in logoArray{
                
           bitcoinPriceLabel.text = String(selectedSymbol) + String( btcResult)
        
            
        
            
        
        }else{
            bitcoinPriceLabel.text = "Không có giá nào hết!"
    }
    




}

}
