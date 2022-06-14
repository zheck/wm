//
//  WMStats.swift
//  WM-Viper
//
//  Created by Fong Zhou on 14/06/2022.
//

import Foundation

struct WMPhotoStats: Decodable {
    let downloads: WMStat?
    let views: WMStat?
    let likes: WMStat?
}

struct WMStat: Decodable {
    let total: Int
}

