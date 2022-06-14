//
//  WMUser.swift
//  WM-Viper
//
//  Created by Fong Zhou on 14/06/2022.
//

import Foundation

struct WMUser: Decodable {
    let id: String
    let name: String?
    let profile_image: [String: URL?]?
    let social: [String: String?]?
}
