//
//  PhotoFactory.swift
//  WM-Viper
//
//  Created by Fong Zhou on 14/06/2022.
//

import Foundation

class PhotoFactory {
    static func build(wmPhotos: [WMPhoto]) -> [Photo] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"

        return wmPhotos.compactMap({ wmPicture in
            guard let url = wmPicture.urls?["regular"],
                  let user = UserFactory.build(user: wmPicture.user) else { return nil }

            var lastUpdate: Date?
            if let updateAt = wmPicture.updated_at {
                lastUpdate = dateFormatter.date(from: updateAt)
            }

            return Photo(
                id: wmPicture.id,
                url: url,
                likes: wmPicture.likes ?? 0,
                lastUpdate: lastUpdate ?? Date(),
                description: wmPicture.description,
                user: user)
        })
    }
}

class UserFactory {
    static func build(user: WMUser?) -> User? {
        guard let user = user, let userName = user.name else { return nil }
        return User(
            id: user.id,
            name: userName,
            picture: user.profile_image?["medium"] ?? nil,
            social: user.social?["twitter_username"] ?? nil
        )
    }
}
