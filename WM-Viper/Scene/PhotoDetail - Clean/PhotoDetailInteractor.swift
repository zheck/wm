//
//  PhotoDetailInteractor.swift
//  WM-Viper
//
//  Created by Fong Zhou on 14/06/2022.
//

import Foundation
import Resolver

protocol PhotoDetailBusinessLogic: Any {
    func fetch() async
}

protocol PhotoDetailDataStore {
    var photo: Photo? { get set }
}

class PhotoDetailInteractor: PhotoDetailBusinessLogic, PhotoDetailDataStore {

    @Injected var presenter: PhotoDetailPresentationLogic
    @Injected var worker: PhotoDetailWorkerLogic

    var photo: Photo?

    func fetch() async {
        guard let photo = photo else { return }

        //let otherPhotos: [Photo] = await worker.fetchUserPhotos(with: photo.user.id)
        //let photoStats: PhotoStats = await worker.fetchPhotoStats(with: photo.id)

        do {
            try await presenter.present(
                photo: photo,
                otherPhotos: worker.fetchUserPhotos(with: photo.user.username),
                stats: worker.fetchPhotoStats(with: photo.id))
        } catch {
            presenter.present(error: error)
        }


//        do {
//            let result = try await [otherPhotos, photoStats]
//        } catch {
//
//        }
//        case .
//        }
//
//        switch await  {
//        case .success(let photoStats):
//            presenter.present(photo: photo, otherPhotos: otherPhotos, stats: photoStats)
//        case .failure(let error):
//            presenter.present(error: error)
//        }

    }
}
