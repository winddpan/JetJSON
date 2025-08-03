//
//  consts.swift
//  JsonZen
//
//  Created by winddpan on 8/2/25.
//

import Foundation

let testJSON: String = {
    let url = Bundle.main.url(forResource: "1MB-min", withExtension: "json")!
    return try! String(contentsOf: url, encoding: .utf8)
}()
