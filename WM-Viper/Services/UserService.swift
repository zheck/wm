//
//  UserService.swift
//  WM-Viper
//
//  Created by Fong Zhou on 14/06/2022.
//

import Foundation
import Resolver

protocol UserService {
    func fetchPhotos(for username: String) async throws -> [Photo]
}

final class DefaultUserService: UserService {

    @Injected var networkClient: NetworkClient

    func fetchPhotos(for username: String) async throws -> [Photo] {
        guard let url = URL(string: "https://api.unsplash.com/users/\(username)/photos") else {
            throw ServiceError.invalidURL
        }

        do {
            let wmPhotos: [WMPhoto] = try await networkClient.request(with: url)
            return PhotoFactory.build(wmPhotos: wmPhotos)
        } catch {
            throw error
        }
    }
}
