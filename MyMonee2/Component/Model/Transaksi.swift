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
    var trxPrice: String?
    var status: Bool = false
    var trxDate: String
    
}

var transaksi: [Transaksi] = [
//    Transaksi(id:0, trxName: "bayar listrik", trxPrice: "75.000", status: true),
//    Transaksi(id:1, trxName: "gajian", trxPrice: "5.000.000", status: false)
]

func getCurrentDate() -> String {
    let date = Date()
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ind")
    formatter.dateFormat = "dd MMMM yyyy - HH.mm"
    let result = formatter.string(from: date)
    return result
}
