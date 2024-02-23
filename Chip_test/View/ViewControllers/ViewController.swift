//
//  ViewController.swift
//  Chip_test
//
//  Created by hanif hussain on 21/02/2024.
//

import UIKit
import Combine


class ViewController: UIViewController, UICollectionViewDelegate {
    let homePageView: HomePageCollectionView = {
        let view = HomePageCollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Dog API"
        setupHomePageView()
    }
    
    func setupHomePageView() {
        view.addSubview(homePageView)
        homePageView.collectionView.delegate = self
        NSLayoutConstraint.activate([
            homePageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            homePageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            homePageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            homePageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dogImageViewController = DogImagesViewController()
        let breed = homePageView.dogs[indexPath.item].breed
        let dataProvider = homePageView.dataProvider
        dataProvider.getImageUrls(breed: breed, numberOfImages: 10) { complete in
            let url = complete
            dogImageViewController.urls = url
            self.navigationController?.pushViewController(dogImageViewController, animated: true)
        }
    }
    
}

