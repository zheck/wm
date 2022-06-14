//
//  HomeService.swift
//  WM-Viper
//
//  Created by Fong Zhou on 14/06/2022.
//

import Foundation

enum ServiceError: Error {
    case invalidURL
    case invalidToken
    case requestOffLimit
}

protocol HomeService: Any {
    func fetchHome(page: Int) async throws -> Home
}

class DefaultHomeService: HomeService {

    private let networkClient = DefaultNetworkClient()

    func fetchHome(page: Int) async throws -> Home {
        guard let url = URL(string: "https://api.unsplash.com/photos?page=\(page)&per_page=20") else {
            throw ServiceError.invalidURL
        }

        do {
            let wmPhotos: [WMPhoto] = try await networkClient.request(with: url)
            return Home(photos: PhotoFactory.build(wmPhotos: wmPhotos))
        } catch {
            throw error
        }
    }

}
