//
//  PhotoDetailViewController.swift
//  WM-Viper
//
//  Created by Fong Zhou on 14/06/2022.
//

import Foundation
import Resolver
import UIKit

protocol PhotoDetailDisplayLogic: AnyObject {
    func display(viewModel: PhotoDetailViewModel)
    func display(error: String)
}

final class PhotoDetailViewController: UIViewController {

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(PhotoDetailCell.self, forCellWithReuseIdentifier: String(describing: PhotoDetailCell.self))
        view.register(PhotoCell.self, forCellWithReuseIdentifier: String(describing: PhotoCell.self))
        view.contentInset = UIEdgeInsets(top: Spacing.medium, left: Spacing.medium, bottom: 0, right: Spacing.medium)
        view.dataSource = self
        view.delegate = self
        return view
    }()

    @Injected var router: PhotoDetailRoutingProtocol
    @Injected private var interactor: PhotoDetailBusinessLogic

    private var viewModel: PhotoDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
        setupConstraints()
        Task {
            await interactor.fetch()
        }
    }

    private func setupInterface() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension PhotoDetailViewController: PhotoDetailDisplayLogic {

    func display(viewModel: PhotoDetailViewModel) {
        Task { @MainActor in
            self.viewModel = viewModel
            collectionView.reloadData()
        }
    }

    func display(error: String) {
        // show prompt
    }
}

extension PhotoDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.userPhotos.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotoDetailCell.self), for: indexPath) as? PhotoDetailCell else {
                fatalError()
            }
            if let picture = viewModel?.photoViewModel {
                cell.setup(with: picture)
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotoCell.self), for: indexPath) as? PhotoCell else {
                fatalError()
            }
            if let url = viewModel?.userPhotos[indexPath.item - 1] {
                cell.setup(with: url)
            }

            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            let width = UIScreen.main.bounds.width - 2*Spacing.medium
            let height = width * 1.4
            return CGSize(width: width, height: height)
        } else {
            let size = (UIScreen.main.bounds.width - 3*Spacing.medium) / 2
            return CGSize(width: size, height: size)
        }
    }

}
