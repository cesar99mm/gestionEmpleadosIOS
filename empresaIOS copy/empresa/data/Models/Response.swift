//
//  Response.swift
//  empresa
//
//  Created by APPS2T on 24/2/22.
//

import Foundation

struct Response: Codable {
    var count: Int
    var next: String?
    var previous: String?
    var results: [Empleado]
}
