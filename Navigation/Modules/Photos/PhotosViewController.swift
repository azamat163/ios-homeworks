//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Азамат Агатаев on 13.11.2021.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    private let photos = PhotosAPI.getPhotos() // массив локальных картинок, хранящиеся в структуре Photo
    private var images: [UIImage] = [] // массив картинок, которые сеттятся из паблишара
    private var userImages: [UIImage] = [] // массив локальных картинок, которые преобразуются из photos
    private let imagePublisherFacade = ImagePublisherFacade() // экземпляр ImagePublisherFacade
    
    deinit {
        imagePublisherFacade.removeSubscription(for: self)
        imagePublisherFacade.rechargeImageLibrary()
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.toAutoLayout()
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = .photosGallery
        navigationController?.navigationBar.prefersLargeTitles = false

        setupViews()
        setupLayout()
        
        imagePublisherFacade.subscribe(self)
        imagePublisherFacade.addImagesWithTimer(time: 1, repeat: 10, userImages: getUserImages())
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        
        collectionView.reloadData()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as? PhotosCollectionViewCell else { fatalError() }
        
        let image = images[indexPath.row]
        cell.configure(with: image)
        
        return cell
    }
}

extension PhotosViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        images.forEach {
            self.images.append($0)
        }
        
        collectionView.reloadData()
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = itemWidth(for: UIScreen.main.bounds.width, spacing: .spacing)
        
        return CGSize(width: width, height: width)
    }
    
    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemInRow: CGFloat = 3
        let totalSpacing: CGFloat = 2 * .spacing + (itemInRow - 1) * .spacing
        return CGFloat(round((width - totalSpacing) / itemInRow))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: .spacing, left: .spacing, bottom: .spacing, right: .spacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .spacing
    }
}

extension PhotosViewController {
    private func getUserImages() -> [UIImage] {
        photos.forEach {
            guard let image = UIImage(named: $0.imageNamed) else { return }
            userImages.append(image)
        }
        return userImages
    }
}

private extension String {
    static let photosGallery = "Photos Gallery"
}

private extension CGFloat {
    static let spacing: CGFloat = 8
}
