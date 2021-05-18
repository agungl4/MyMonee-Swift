//
//  Userdata.swift
//  MyMonee2
//
//  Created by MacTavish on 17/05/21.
//

import Foundation

struct Userdata: Codable {
    var userName: String
    var userBalance: Double
    var userIncome: Double
    var userExpense: Double
}

var userData: [Userdata] = [Userdata(userName: "john doe", userBalance: 0.0, userIncome: 0.0, userExpense: 0.0)]
