//
//  PhotoService.swift
//  WM-Viper
//
//  Created by Fong Zhou on 14/06/2022.
//

import Foundation
import Resolver

protocol PhotoDetailService {
    func fetchStats(for photoID: String) async throws -> PhotoStats
}

final class DefaultPhotoDetailService: PhotoDetailService {

    @Injected var networkClient: NetworkClient

    func fetchStats(for photoID: String) async throws -> PhotoStats {
        guard let url = URL(string: "https://api.unsplash.com/photos/\(photoID)/statistics") else {
            throw ServiceError.invalidURL
        }

        do {
            let wmPhotoStats: WMPhotoStats = try await networkClient.request(with: url)
            return PhotoStats(
                downloads: wmPhotoStats.downloads?.total ?? 0,
                likes: wmPhotoStats.likes?.total ?? 0,
                views: wmPhotoStats.views?.total ?? 0
            )
        } catch {
            throw error
        }
    }
}

