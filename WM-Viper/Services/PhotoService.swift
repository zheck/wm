//
//  PhotoService.swift
//  WM-Viper
//
//  Created by Fong Zhou on 14/06/2022.
//

import Foundation

protocol PhotoDetailService {
    func fetchStats(for photoID: String) -> PhotoStats
}

final class DefaultPhotoDetailService: PhotoDetailService {

    func fetchStats(for photoID: String) -> PhotoStats {
        do {
            let wmPhotoStats = try JSONDecoder().decode(WMPhotoStats.self, from: userResponse)
            return PhotoStats(
                downloads: wmPhotoStats.downloads?.total ?? 0,
                likes: wmPhotoStats.likes?.total ?? 0,
                views: wmPhotoStats.views?.total ?? 0
            )
        } catch {
            print(error)
        }
        return PhotoStats(downloads: 0, likes: 0, views: 0)
    }
}

