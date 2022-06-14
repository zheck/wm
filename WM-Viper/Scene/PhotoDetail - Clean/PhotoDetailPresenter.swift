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
    func present(error: Error)
}

final class PhotoDetailPresenter: PhotoDetailPresentationLogic {

    @WeakLazyInjected var display: PhotoDetailDisplayLogic?

    func inject(display: PhotoDetailDisplayLogic) {
        self.display = display
    }

    func present(photo: Photo, otherPhotos: [Photo], stats: PhotoStats) {
        let viewModel = PhotoDetailViewModel(
            photoViewModel: getPhotoViewModelNoTime(photo: photo),
            photoUrl: photo.url,
            userPicture: photo.user.picture,
            userName: photo.user.username,
            userSocial: photo.user.social,
            description: photo.description,
            numberOfDownloads: stats.downloads,
            numberOfViews: stats.views,
            numberOfLikes: stats.likes,
            userPhotos: otherPhotos.map({ $0.url })
        )
        display?.display(viewModel: viewModel)
    }

    func present(error: Error) {
        display?.display(error: error.localizedDescription)
    }

    func getPhotoViewModelNoTime(photo: Photo) -> PhotoViewModel {
        let calendar = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: photo.lastUpdate, to: .now)

        // don't want to waste time here, just gave in days
        var string = "now"
        if let seconds = calendar.second {
            string = "\(seconds) s"
        }

        return PhotoViewModel(
            id: photo.id,
            photoUrl: photo.url,
            userPicture: photo.user.picture,
            userName: photo.user.username,
            userSocial: photo.user.social,
            lastUpdate: string,
            description: photo.description,
            numberOfLikes: photo.likes)
    }
}
