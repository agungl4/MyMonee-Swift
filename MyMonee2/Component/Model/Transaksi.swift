//
//  Transaksi.swift
//  MyMonee2
//
//  Created by MacTavish on 13/05/21.
//

import Foundation

struct TransaksiResponse: Codable {
    var results: [Transaksi]?
}

struct Transaksi: Codable {
    var id: String?
    var trxName: String?
    var trxPrice: Int?
    var status: Bool = false
    var trxDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case trxName
        case trxPrice
        case status
        case trxDate
    }
    
}

