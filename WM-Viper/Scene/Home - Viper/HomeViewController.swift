//
//  HomeViewController.swift
//  WM-Viper
//
//  Created by Fong Zhou on 14/06/2022.
//

import Foundation
import UIKit

final class HomeViewController: UIViewController {

    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Rechercher..."
        searchController.searchBar.delegate = self
        searchController.delegate = self
        return searchController
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(PhotoDetailCell.self, forCellWithReuseIdentifier: String(describing: PhotoDetailCell.self))
        view.contentInset = UIEdgeInsets(top: Spacing.medium, left: Spacing.medium, bottom: 0, right: Spacing.medium)
        view.dataSource = self
        view.delegate = self
        return view
    }()

    private var presenter: ViewToPresenterHomeProtocol?
    private var viewModel: HomeViewModel?

    func inject(presenter: ViewToPresenterHomeProtocol) {
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
        setupConstraints()
        Task {
            await presenter?.start()
        }
    }

    private func setupInterface() {
        navigationItem.searchController = searchController
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

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.pictures.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotoDetailCell.self), for: indexPath) as? PhotoDetailCell else {
            fatalError()
        }
        if let picture = viewModel?.pictures[indexPath.item] {
            cell.setup(with: picture)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 2*Spacing.medium
        let height = width * 1.4
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = viewModel?.pictures[indexPath.item].id,
              let navigationController = navigationController else { return }
        presenter?.showPhotoDetail(with: id, navigationController: navigationController)
    }
}

extension HomeViewController: UISearchBarDelegate, UISearchControllerDelegate {

}

extension HomeViewController: PresenterToViewHomeProtocol {

    func display(viewModel: HomeViewModel) {
        Task { @MainActor in
            self.viewModel = viewModel
            collectionView.reloadData()
        }
    }

    func displayError(_ error: String) {
    }
}
