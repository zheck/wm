//
//  PhotoDetailModel.swift
//  WM-Viper
//
//  Created by Fong Zhou on 14/06/2022.
//

import Foundation

struct PhotoDetailViewModel {
    let photoUrl: URL
    let userPicture: URL?
    let userName: String
    let userSocial: String?
    let description: String?
    let numberOfDownloads: Int
    let numberOfViews: Int
    let numberOfLikes: Int
    let userPhotos: [URL]
}

