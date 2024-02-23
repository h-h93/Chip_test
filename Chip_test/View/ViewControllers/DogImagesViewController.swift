//
//  DogImagesViewController.swift
//  Chip_test
//
//  Created by hanif hussain on 22/02/2024.
//

import UIKit

class DogImagesViewController: UIViewController {
    let dogImageView: DogImagesCollectionView = {
        let view = DogImagesCollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var urls = [String]()
    var images = [UIImage]()
    let dataProvider = DataProvider()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Dog Pics"
        view.backgroundColor = .white
        getImages()
        setupHomePageView()
    }
    
    func setupHomePageView() {
        view.addSubview(dogImageView)
        NSLayoutConstraint.activate([
            dogImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dogImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            dogImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            dogImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    // download the images to display
    func getImages() {
        if !urls.isEmpty {
            DispatchQueue.global(qos: .background).async {
                for i in self.urls {
                    let url = URL(string: i)!
                    self.dataProvider.downloadImages(url) { image in
                        DispatchQueue.main.async {
                            self.dogImageView.images.append(image)
                            self.dogImageView.collectionView.reloadData()
                        }
                    }
                }
            }
        }
    }

}
