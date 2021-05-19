//
//  Transaksi.swift
//  MyMonee2
//
//  Created by MacTavish on 13/05/21.
//

import Foundation

struct Transaksi {
    var id: Int?
    var trxName: String?
    var trxPrice: Double?
    var status: Bool = false
    var trxDate: String
    
}

var transaksi: [Transaksi] = [Transaksi]()

func getCurrentDate() -> String {
    let date = Date()
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ind")
    formatter.dateFormat = "dd MMMM yyyy - HH.mm"
    let result = formatter.string(from: date)
    return result
}
