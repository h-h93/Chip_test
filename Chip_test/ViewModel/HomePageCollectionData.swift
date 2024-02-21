//
//  HomePageCollectionData.swift
//  Chip_test
//
//  Created by hanif hussain on 21/02/2024.
//

import Foundation
import UIKit

class HomePageCollectionData: NSObject, UICollectionViewDataSource {
//    // create instance of our data provider so we can grab dogs
//    let dataProvider = DataProvider()
//    // initiliase a url to pull dogs
//    let url = URL(string: "https://dog.ceo/api/breeds/list/all")!
//    
//    var dogs = [String]()
    
    let response = Response()
    
    override init() {
        super.init()
//        dataProvider.fetchDogs(url) { completion in
//            // convert dogs dictionary to array
//            self.dogs = Array(completion.message.keys)
//            // get a random image to display
//            
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomHomeCollectionViewCell
        //cell.backgroundColor = .random
        cell.layer.cornerRadius = 10
        cell.textView.text = response.dogs[indexPath.item]
        cell.imageView.image = response.dogPics[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return response.dogs.count
    }
}
