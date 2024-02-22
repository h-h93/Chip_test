//
//  ViewController.swift
//  Chip_test
//
//  Created by hanif hussain on 21/02/2024.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate {
    let dataProvider = DataProvider()
    
    let homePageView: HomePageCollectionView = {
        let view = HomePageCollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // grab our dogs data
        dataProvider.fetchDogs { dogs in
            // send pass it along to populate our collection view
            self.homePageView.dogs = dogs
            // reload our data on main
            DispatchQueue.main.async {
                self.homePageView.collectionView.reloadData()
            }
        }

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
        let dogBreed = homePageView.dogs[indexPath.item]
        dataProvider.getImageUrls(breed: dogBreed, numberOfImages: 10) { complete in
            dogImageViewController.urls = complete
            self.navigationController?.pushViewController(dogImageViewController, animated: true)
        }
    }


}

