//
//  HomeService.swift
//  WM-Viper
//
//  Created by Fong Zhou on 14/06/2022.
//

import Foundation

enum ServiceError: Error {
    case invalidToken
    case requestOffLimit
}

protocol HomeService: Any {
    func fetchHome() -> Home
}

class DefaultHomeService: HomeService {

    private var presenter: InteractorToPresenterHomeProtocol?

    func inject(presenter: InteractorToPresenterHomeProtocol) {
        self.presenter = presenter
    }

    func fetchHome() -> Home {
        do {
            let wmPhotos = try JSONDecoder().decode([WMPhoto].self, from: response)
            return Home(photos: PhotoFactory.build(wmPhotos: wmPhotos))
        } catch {
            print(error)
        }
        return Home(photos: PhotoFactory.build(wmPhotos: []))
    }

}
