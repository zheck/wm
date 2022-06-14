//
//  UserService.swift
//  WM-Viper
//
//  Created by Fong Zhou on 14/06/2022.
//

import Foundation

protocol UserService {
    func fetchPhotos(for user: String) -> [Photo]
}

final class DefaultUserService: UserService {
    func fetchPhotos(for user: String) -> [Photo] {
        do {
            let wmPhotos = try JSONDecoder().decode([WMPhoto].self, from: userResponse)
            return PhotoFactory.build(wmPhotos: wmPhotos)
        } catch {
            print(error)
        }
        return []
    }
}
