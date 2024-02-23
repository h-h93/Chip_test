//
//  DataRequest.swift
//  Chip_test
//
//  Created by hanif hussain on 21/02/2024.
//

import Foundation
import Combine
import UIKit

enum JsonError: Error {
    case failedRequest
}

class DataProvider {
    // initialise our request calls
    let request = Requests()
    // initiliase a url to pull dogs
    let url = URL(string: "https://dog.ceo/api/breeds/list/all")!
    // url to get images of dog breeds
    let imageURL = "https://dog.ceo/api/breed/"
    // hold struct of dogs
    var dogsList: Dogs?
    // store our dogs in our custom struct to hold extra data
    var dogsModel = [DogsModel]()
    
    init() {
        
    }
    
    func fetchDogs(completed: @escaping (DogsModel) -> Void) {
        request.fetchDogs(url) { completion in
            self.dogsList = completion
            // convert dogs dictionary to array
            let dogs = Array(completion.message.keys)
            // lets iterate over our dogs
            for i in dogs {
                // get an image url string
                self.getImageUrls(breed: i, numberOfImages: 1) { complete in
                    // convert it to a url
                    let url = URL(string: complete.first!)
                    // create a custom dog model
                    let dog = DogsModel(breed: i, imageURL: url!)
                    // we've got ourself a dog let's escape and return dog
                    completed(dog)
                }
            }
        }
    }
    
    // we have to parse the url response to get the string url's so we can download images
    func getImageUrls(breed: String, numberOfImages: Int, complete: @escaping (([String]) -> Void)) {
        // how many images should we download?
        let number = String(numberOfImages)
        // create the string to get number of random images of breed of dog
        let breedurl = ("\(imageURL)\(breed)/images/random/\(number)")
        // convert to url
        let imgURL = URL(string: breedurl)!
        // if we can't get a response provide nil ( we have counter for this later on by providing default dog image)
        let defaultValue = DogImages(message: nil, status: nil)
        // first get the image urls
        request.fetchRequest(imgURL, defaultValue: defaultValue) { completion in
            // first get the image urls
            self.request.fetchRequest(imgURL, defaultValue: defaultValue) { completion in
                // capture the download urls so we can use them
                complete(completion.message!)
            }
        }
    }
    
    // download images and provide a completion handler that return an image
    func downloadImages(_ url: URL, completed: @escaping (UIImage) -> Void) {
        let defaultValue = UIImage(systemName: "xmark")!.pngData()!
        self.request.fetchData(url, defaultValue: defaultValue) { data in
            let image = UIImage(data: data)
            completed(image!) // we can force unwrap as we providing a default image in case of error
        }
    }
}
