//
//  Response.swift
//  Chip_test
//
//  Created by hanif hussain on 21/02/2024.
//

import Foundation
import UIKit

class Response {
    // create instance of our data provider so we can grab dogs
    let dataProvider = DataProvider()
    // initiliase a url to pull dogs
    let url = URL(string: "https://dog.ceo/api/breeds/list/all")!
    // url to get images of dog breeds
    let imageURL = "https://dog.ceo/api/breed/"
    // hold struct of dogs
    var dogsList: Dogs?
    // convert dogs struct to hold breed
    var dogs = [String]()
    // hold images of our dog pics
    var dogPics = [UIImage]()
    
    init() {
        dataProvider.fetchDogs(url) { completion in
            self.dogsList = completion
            // convert dogs dictionary to array
            self.dogs = Array(completion.message.keys)
            // get a random images to display for each breed
            self.getImages()
        }

    }
    
    func getImages() {
        for i in dogs {
            let breedurl = ("\(imageURL)\(i)/images")
            let img = URL(string: breedurl)!
            dataProvider.fetchImages(img) { completion in
                self.dogPics.append(completion)
            }
        }
    }
}
