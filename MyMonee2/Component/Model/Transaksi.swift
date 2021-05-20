//
//  Transaksi.swift
//  MyMonee2
//
//  Created by MacTavish on 13/05/21.
//

import Foundation

struct Transaksi: Codable {
    var id: Int?
    var trxName: String?
    var trxPrice: Double?
    var status: Bool = false
    var trxDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case trxName = "trx_name"
        case trxPrice
        case status
        case trxDate = "trx_date"
    }
    
}

var transaksi: [Transaksi] = [Transaksi]()

