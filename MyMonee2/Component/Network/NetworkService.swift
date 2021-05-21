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
//                print(String(data: data!, encoding: String.Encoding.utf8)!)
            }
            task.resume()
        }
    }
    
    func createTransaction(transaction: Transaksi) {
        guard let json = try? JSONEncoder().encode(transaction) else {
            return
        }
        
        guard let url = URL(string: self.url) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
        request.httpBody = json
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            guard error == nil else {
                print("Error: error calling POST")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    print("Error: Cannot convert data to JSON object")
                    return
                }
                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                    print("Error: Cannot convert JSON object to Pretty JSON data")
                    return
                }
                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                    print("Error: Couldn't print JSON in String")
                    return
                }
                
                print(prettyPrintedJson)
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }.resume()
        
    }
    
    func updateTransaction(data: Transaksi) {
        print("ID payload, ", data.id)
        guard let url = URL(string: "\(self.url)/\(String(describing: data.id!))") else {
            print("URL ERROR")
            return
        }
        print(self.url)
               // Add data to the model
//               let uploadDataModel = UploadData(name: "Nicole", job: "iOS Developer")
               
               // Convert model to JSON data
               guard let jsonData = try? JSONEncoder().encode(data) else {
                   print("Error: Trying to convert model to JSON data")
                   return
               }
                print(data)
               // Create the request
               var request = URLRequest(url: url)
               request.httpMethod = "PUT"
               request.setValue("application/json", forHTTPHeaderField: "Content-Type")
               request.httpBody = jsonData
               URLSession.shared.dataTask(with: request) { data, response, error in
                   guard error == nil else {
                       print("Error: error calling PUT")
                       print(error!)
                       return
                   }
                   guard let data = data else {
                       print("Error: Did not receive data")
                       return
                   }
                   guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                       print("Error: HTTP request failed")
                       return
                   }
                   do {
                       guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                           print("Error: Cannot convert data to JSON object")
                           return
                       }
                       guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                           print("Error: Cannot convert JSON object to Pretty JSON data")
                           return
                       }
                       guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                           print("Error: Could print JSON in String")
                           return
                       }
                       
                       print(prettyPrintedJson)
                   } catch {
                       print("Error: Trying to convert JSON data to string")
                       return
                   }
               }.resume()
    }
    
    func deleteTransaction(id: String){
        guard let url = URL(string: self.url+"/\(id)") else {
                   print("Error: cannot create URL")
                   return
               }
            
        var request = URLRequest(url: url)
               request.httpMethod = "DELETE"
               URLSession.shared.dataTask(with: request) { data, response, error in
                   guard error == nil else {
                       print("Error: error calling DELETE")
                       print(error!)
                       return
                   }
                   guard let data = data else {
                       print("Error: Did not receive data")
                       return
                   }
                   guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                       print("Error: HTTP request failed")
                       return
                   }
                   do {
                       guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                           print("Error: Cannot convert data to JSON")
                           return
                       }
                       guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                           print("Error: Cannot convert JSON object to Pretty JSON data")
                           return
                       }
                       guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                           print("Error: Could print JSON in String")
                           return
                       }
                       
                       print(prettyPrintedJson)
                   } catch {
                       print("Error: Trying to convert JSON data to string")
                       return
                   }
               }.resume()
    }
}


