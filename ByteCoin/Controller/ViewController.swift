//
//  ViewController.swift
//  ByteCoin
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }
    

}

// MARK: - UIPickerViewDataSource
extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}

// MARK: - UIPickerViewDelegate
extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.getCoinPrice(coinManager.currencyArray[row])
    }
}

// MARK: - CoinManagerDelegate
extension ViewController: CoinManagerDelegate {
    func didUpdateRate(_ coinManager: CoinManager, _ coinModel: CoinRateModel) {
        DispatchQueue.main.async {
            self.currencyLabel.text = coinModel.rateString
            self.bitcoinLabel.text = coinModel.to
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
