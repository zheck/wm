//
//  PhotoDetailWorker.swift
//  WM-Viper
//
//  Created by Fong Zhou on 14/06/2022.
//

import Foundation
import Resolver

struct PhotoDetail {

}

protocol PhotoDetailWorkerLogic {
    func fetchUserPhotos(with id: String) -> [Photo]
    func fetchPhotoStats(with id: String) -> PhotoStats
}

final class PhotoDetailWorker: PhotoDetailWorkerLogic {

    @Injected private var service: PhotoDetailService
    @Injected private var userService: UserService

    func fetchUserPhotos(with id: String) -> [Photo] {
        return userService.fetchPhotos(for: id)
    }

    func fetchPhotoStats(with id: String) -> PhotoStats {
        return service.fetchStats(for: id)
    }
}

