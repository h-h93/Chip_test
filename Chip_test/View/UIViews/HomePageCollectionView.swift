//
//  HomePageCollectionView.swift
//  Chip_test
//
//  Created by hanif hussain on 21/02/2024.
//

import UIKit

class HomePageCollectionView: UIView, UICollectionViewDataSource {
    let dataProvider = DataProvider()
    var collectionView: UICollectionView!
    var dogs = [DogsModel]()
    var displayImages = [UIImage]()
    let image = UIImage(systemName: "dog")?.withRenderingMode(.alwaysTemplate)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        // grab our dogs data
        dataProvider.fetchDogs { dogs in
            // reload our data on main
            DispatchQueue.main.async {
                // pass it along to populate our collection view
                self.dogs.append(dogs)
                print(dogs.imageURL)
                self.collectionView.reloadData()
            }
        }
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: getCompositionalLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.register(CustomHomeCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func getCompositionalLayout() -> UICollectionViewCompositionalLayout {
        // left panel takes full width and height
        let leftPanel = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        leftPanel.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        // right panel takes full width and height
        let rightPanel = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        rightPanel.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        // create our nested group to contain left panel and right panel squares going vertically i.e. side by side specifying that each item in the sub items should be 0.5 width of the screen so left panel is half the width and right panel is half the width of the screen this let's us layout two panels side by side. I've also specified that both panels should take up the full height of the main group they will be contained in
        let leftAndRightPanelGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)), subitems: [leftPanel, rightPanel])
        
        // each item is contained in a group think of a group as an almost cell, the group we specified here contains our nested left and right panel group in a main group that takes up the full width of the screen and half the height of the view
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)), subitems: [leftAndRightPanelGroup])
        
        //--------- Container Group ---------//
        let containerGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: [group])
        let section = NSCollectionLayoutSection(group: containerGroup)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomHomeCollectionViewCell
        //cell.backgroundColor = .random
        cell.layer.cornerRadius = 10
        cell.textView.text = dogs[indexPath.item].breed
        // only get images if and when we need, if i was using kingfisher i would move this download image code to init and store images in swift data then pull images from there
        if dogs[indexPath.item].image == image || dogs[indexPath.item].image == nil {
            downloadImage(dog: dogs[indexPath.item], index: indexPath.item)
            cell.imageView.image = image
        } else {
            let image = dogs[indexPath.item].image
            cell.imageView.image = image
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dogs.count
    }
    
    // currently downloading 1 image for each dog to display. Not using Kingfisher library to cache and also in general to store the image as i'm not sure if allowed to use 3rd party lib.
    func downloadImage(dog: DogsModel, index: Int) {
            self.dataProvider.downloadImages(dog.imageURL) { image in
                let compressedImg = image.jpegData(compressionQuality: 0.5)
                self.dogs[index].image = UIImage(data: compressedImg!)
            }
    }
    
}
