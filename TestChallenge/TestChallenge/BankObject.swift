//
//  BankObject.swift
//  Challenge
//
//  Created by RicrdoRS on 4/29/20.
//  Copyright © 2020 Desarrollador1. All rights reserved.
//

import Foundation

public struct BankObject: Codable {

    public var bankName        : String?
    public var description     : String?
    public var age             : Int?
    public var url             : String?
    
    public init() {}
}
