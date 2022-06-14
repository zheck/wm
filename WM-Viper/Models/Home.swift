//
//  Home.swift
//  WM-Viper
//
//  Created by Fong Zhou on 14/06/2022.
//

import Foundation

struct Home {
    let photos: [Photo]
}

struct Photo {
    let id: String
    let url: URL
    let likes: Int
    let lastUpdate: Date
    let description: String?
    let user: User
}

struct User {
    let id: String
    let username: String
    let picture: URL?
    let social: String?
}

struct PhotoStats {
    let downloads: Int
    let likes: Int
    let views: Int
}
