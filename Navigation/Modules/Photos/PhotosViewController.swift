//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Азамат Агатаев on 13.11.2021.
//

import UIKit
import iOSIntPackage

final class PhotosViewController: UIViewController {
    
    private let photos = PhotosAPI.getPhotos() // массив локальных картинок, хранящиеся в структуре Photo
    private var images: [UIImage] = [] // массив картинок, которые сеттятся из паблишара
    private var userImages: [UIImage] = [] // массив локальных картинок, которые преобразуются из photos
    private let imagePublisherFacade = ImagePublisherFacade() // экземпляр ImagePublisherFacade
    private let imageProcessor = ImageProcessor()
    
    deinit {
        imagePublisherFacade.removeSubscription(for: self)
        imagePublisherFacade.rechargeImageLibrary()
    }
    
    private lazy var collectionView: UICollectionView = {
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initUserImages()
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as? PhotosCollectionViewCell else { preconditionFailure("Unable to cast cell to PhotosCollectionViewCell") }
        
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
    /// Результаты измерения:
    /// Время выполнения с qos: default = 1218.0 miliseconds
    /// Время выполнения с qos: background = 5002.0 miliseconds
    /// Время выполнения с qos: userInitiated = 1045.0 miliseconds
    /// Время выполнения с qos: utility = 1532.0 miliseconds
    /// Время выполнения с qos: userInteractive = 987.0 miliseconds
    private func initUserImages() {
        let sourceImages: [UIImage] = photos.compactMap { photo in UIImage(named: photo.imageNamed) }
        
        guard let filter = ColorFilter.allCases.randomElement() else { return }
        guard let qos = QualityOfService.allCases.randomElement() else { return }
        
        let start = DispatchTime.now()
        imageProcessor.processImagesOnThread(
            sourceImages: sourceImages,
            filter: filter,
            qos: qos,
            completion: { cgImages in
                self.userImages = cgImages.compactMap({ cgImage in
                    guard let cgImage = cgImage else { preconditionFailure("Unable to fetch filter image") }
                    return UIImage(cgImage: cgImage)
                })
                let end = DispatchTime.now()
                let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
                let elapsedTime = Double(nanoTime / 1_000_000)
                print("Время выполнения с qos: \(qos.description) = \(elapsedTime) miliseconds")
                
                DispatchQueue.main.async {
                    self.imagePublisherFacade.subscribe(self)
                    self.imagePublisherFacade.addImagesWithTimer(
                        time: 0.25,
                        repeat: 10,
                        userImages: self.userImages
                    )
                }
            }
        )
    }
}

private extension String {
    static let photosGallery = String(localized: "photos.header.title")
}

private extension CGFloat {
    static let spacing: CGFloat = 8
}

extension QualityOfService: CaseIterable, CustomStringConvertible {
    public static var allCases: [QualityOfService] {
        return [.userInteractive, .userInitiated, .background, .default, .utility]
    }
    
    public var description: String {
        switch self {
        case .utility:
            return "utility"
        case .background:
            return"background"
        case .userInteractive:
            return "userInteractive"
        case .userInitiated:
            return "userInitiated"
        case .default:
            return "default"
        @unknown default:
            return "unknown default"
        }
    }
}
