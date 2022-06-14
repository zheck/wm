//
//  PhotoDetailPresenter.swift
//  WM-Viper
//
//  Created by Fong Zhou on 14/06/2022.
//

import Foundation
import Resolver

protocol PhotoDetailPresentationLogic {
    func present(photo: Photo, otherPhotos: [Photo], stats: PhotoStats)
}

final class PhotoDetailPresenter: PhotoDetailPresentationLogic {

    @WeakLazyInjected var display: PhotoDetailDisplayLogic?

    func inject(display: PhotoDetailDisplayLogic) {
        self.display = display
    }

    func present(photo: Photo, otherPhotos: [Photo], stats: PhotoStats) {
        let viewModel = PhotoDetailViewModel(
            photoUrl: photo.url,
            userPicture: photo.user.picture,
            userName: photo.user.name,
            userSocial: photo.user.social,
            description: photo.description,
            numberOfDownloads: stats.downloads,
            numberOfViews: stats.views,
            numberOfLikes: stats.likes,
            userPhotos: otherPhotos.map({ $0.url })
        )
        display?.display(viewModel: viewModel)
    }
}
