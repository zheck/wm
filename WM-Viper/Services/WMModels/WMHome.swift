//
//  WMHome.swift
//  WM-Viper
//
//  Created by Fong Zhou on 14/06/2022.
//

import Foundation

struct WMHome: Decodable {
    
}

struct WMPhoto: Decodable {
    let id: String
    let urls: [String: URL]?
    let likes: Int?
    let updated_at: String?
    let description: String?
    let user: WMUser?
}
