//
//  PhotoDetailInteractor.swift
//  WM-Viper
//
//  Created by Fong Zhou on 14/06/2022.
//

import Foundation
import Resolver

protocol PhotoDetailBusinessLogic: Any {
    func fetch()
}

protocol PhotoDetailDataStore {
    var photo: Photo? { get set }
}

class PhotoDetailInteractor: PhotoDetailBusinessLogic, PhotoDetailDataStore {

    @Injected var presenter: PhotoDetailPresentationLogic
    @Injected var worker: PhotoDetailWorkerLogic

    var photo: Photo?

    func fetch() {
        guard let photo = photo else { return }
        let otherPhotos = worker.fetchUserPhotos(with: photo.user.id)
        let stats = worker.fetchPhotoStats(with: photo.id)
        presenter.present(photo: photo, otherPhotos: otherPhotos, stats: stats)
    }
}
