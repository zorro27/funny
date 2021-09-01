//
//  GallaryCVC.swift
//  mobileup
//
//  Created by Роман Зобнин on 01.08.2021.
//

import UIKit
import Kingfisher
import WebKit

private let reuseIdentifier = "Cell"

protocol GalleryCollectionViewControllerDelegate: AnyObject {
    func eraseToken(token: String)
}

class GalleryCollectionViewController: UICollectionViewController {

    weak var delegate: GalleryCollectionViewControllerDelegate?

    var items: [Item] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        registerCell()
        setLayout()
    }

    func setupViews() {
        collectionView.backgroundColor = .systemBackground
        setExitButton()
    }

    func setExitButton() {
        let exitButton = UIBarButtonItem()
        exitButton.title = "Выход"
        exitButton.tintColor = .black
        exitButton.action = #selector(exitButtonTapped(sender:))
        exitButton.target = self

        navigationItem.setRightBarButton(exitButton, animated: true)
    }

    @objc func exitButtonTapped(sender: UIBarButtonItem) {
        removeCookies()
        dismiss(animated: true, completion: nil)
        delegate?.eraseToken(token: "")
    }

    func removeCookies() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)

        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
    }

    func registerCell() {
        let nib = UINib(nibName: "GalleryCollectionViewCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "Cell")
    }

    func setLayout() {
        collectionView.setCollectionViewLayout(generateLayout(), animated: false)
    }

    private func generateLayout() -> UICollectionViewLayout {

        let spacing: CGFloat = 1

        let item = setItemLayout(spacing)
        let group = setGroupLayout(spacing, item: item)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    private func setItemLayout(_ spacing: CGFloat) -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: spacing,
            bottom: 0,
            trailing: spacing
        )
        return item
    }

    private func setGroupLayout(_ spacing: CGFloat, item: NSCollectionLayoutItem) -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(0.5)
        )

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)

        group.contentInsets = NSDirectionalEdgeInsets(
            top: spacing,
            leading: spacing,
            bottom: 0,
            trailing: spacing
        )
        return group
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? GalleryCollectionViewCell else { return UICollectionViewCell() }

        // Configure the cell
        let itemSizeIndex = 4
        let url = URL(string: items[indexPath.item].sizes[itemSizeIndex].url)

        cell.backgroundColor = .systemTeal
        cell.clipsToBounds = true
        cell.imageView.kf.setImage(with: url)
        cell.imageView.contentMode = .scaleAspectFill

        return cell
    }

    // Sets custom back button for didSelectItemAt

    func setBackButtonSettings() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.image = UIImage(named: "Back_button")
        backButton.tintColor = .black
        navigationItem.backBarButtonItem = backButton
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = ImageViewController()
        setBackButtonSettings()

        let itemSizeIndex = 6
        viewController.imageLink = items[indexPath.item].sizes[itemSizeIndex].url
        let date = Date(timeIntervalSince1970: TimeInterval(items[indexPath.item].date))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMMM YYYY"
        viewController.navigationItem.title = dateFormatter.string(from: date)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
