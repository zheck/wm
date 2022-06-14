//
//  PhotoDetailWorker.swift
//  WM-Viper
//
//  Created by Fong Zhou on 14/06/2022.
//

import Foundation
import Resolver

protocol PhotoDetailWorkerLogic {
    func fetchUserPhotos(with username: String) async throws -> [Photo]
    func fetchPhotoStats(with id: String) async throws -> PhotoStats
}

final class PhotoDetailWorker: PhotoDetailWorkerLogic {

    @Injected private var service: PhotoDetailService
    @Injected private var userService: UserService

    func fetchUserPhotos(with username: String) async throws -> [Photo] {
        try await userService.fetchPhotos(for: username)
    }

    func fetchPhotoStats(with id: String) async throws -> PhotoStats {
        try await service.fetchStats(for: id)
    }
}

