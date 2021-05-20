//
//  NetworkService.swift
//  MyMonee2
//
//  Created by MacTavish on 20/05/21.
//

import Foundation

class NetworkService{
    let url: String = "https://60a5e442c0c1fd00175f4988.mockapi.io/api/v1/transaction"
    
    func loadTrxList(completion: @escaping (_ transaksi: [Transaksi]) -> ()) {
        let component = URLComponents(string: self.url)
        
        if let url = component?.url {
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
                if let data = data {
                    let decoder = JSONDecoder()
                    if let trxList = try? decoder.decode(TransaksiResponse.self, from: data) as TransaksiResponse {
                        completion(trxList.results ?? [])
                    }
                }
                print(String(data: data!, encoding: String.Encoding.utf8)!)
            }
            task.resume()
        }
    }
}
