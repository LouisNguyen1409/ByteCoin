//
//  CoinManager.swift
//  ByteCoin
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateRate(_ coinManager: CoinManager, _ coinModel: CoinRateModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    var delegate: CoinManagerDelegate?
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "5461F30E-251E-4F5E-8EC3-265A2365B4A4"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(_ currency: String) {
        let url = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(url)
    }
    
    func performRequest(_ urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: handler(data:response:error:))
            task.resume()
        }
        
    }
    
    func handler(data: Data?, response: URLResponse?, error: Error?) {
        if error != nil {
            self.delegate?.didFailWithError(error: error!)
        }
        
        if let safeData = data {
            if let rate = parseJSON(safeData) {
                self.delegate?.didUpdateRate(self, rate)
            }
        }
    }
    
    func parseJSON(_ rate: Data) -> CoinRateModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(CoinRateData.self, from: rate)
            let rateData = CoinRateModel(from: decodeData.asset_id_base, to: decodeData.asset_id_quote, rate: decodeData.rate)
            return rateData
        } catch {
            self.delegate?.didFailWithError(error: error)
        }
        return nil
    }
    
}
