//
//  HomeModel.swift
//  WM-Viper
//
//  Created by Fong Zhou on 14/06/2022.
//

import Foundation

struct HomeViewModel {
    let pictures: [PhotoViewModel]
}

struct PhotoViewModel {
    let id: String
    let photoUrl: URL
    let userPicture: URL?
    let userName: String
    let userSocial: String?
    let lastUpdate: String
    let description: String?
    let numberOfLikes: Int
}
