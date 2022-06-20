//
//  HomeProtocols.swift
//  WM-Viper
//
//  Created by Fong Zhou on 14/06/2022.
//

import Foundation

protocol ViewToPresenterHomeProtocol: Any {
    func viewDidLoad() async
    func numberOfItems() -> Int
    func photo(at indexPath: IndexPath) -> PhotoViewModel?
    func didSelectItem(at indexPath: IndexPath)
}

protocol PresenterToViewHomeProtocol: AnyObject {
    func onFetchSucceess()
    func onFetchFailure()
}

protocol PresenterToRouterHomeProtocol: Any {
    func routeToPhotoDetail(with photo: Photo, view: PresenterToViewHomeProtocol)
}

protocol PresenterToInteractorHomeProtocol: Any {
    func fetch() async
    func retrievePhoto(at index: Int)
}

protocol InteractorToPresenterHomeProtocol: Any {
    func fetchHomeSuccess(home: Home)
    func fetchHomeFailed(error: Error)
    func retrievePhotoSuccess(photo: Photo)
    func retrievePhotoFailure()
}
