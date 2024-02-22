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
    // hold our dog pics
    var dogPics = [UIImage]()
    
    init() {
        
    }
    
    func fetchDogs(completed: @escaping ([String]) -> Void) {
        request.fetchDogs(url) { completion in
            self.dogsList = completion
            // convert dogs dictionary to array
            let dogs = Array(completion.message.keys)
            completed(dogs)
        }
    }
    
    // we have to first parse the response into our struct containing the image urls
    func getImageUrls(breed: String, numberOfImages: Int, complete: @escaping (([String]) -> Void)) {
        let number = String(numberOfImages)
        let breedurl = ("\(imageURL)\(breed)/images/random/\(number)")
        let imgURL = URL(string: breedurl)!
        let defaultValue = DogImages(message: nil, status: nil)
        // first get the image urls
        request.fetchRequest(imgURL, defaultValue: defaultValue) { completion in
            let imgURL = URL(string: breedurl)!
            let defaultValue = DogImages(message: nil, status: nil)
            // first get the image urls
            self.request.fetchRequest(imgURL, defaultValue: defaultValue) { completion in
                // capture the download urls so we can use them 
                complete(completion.message!)
            }
        }
    }
    
    func downloadImages(_ url: URL, completed: @escaping (UIImage) -> Void) {
        var defaultValue = UIImage(systemName: "xmark")!.pngData()!
//        self.request.getData(url: url) { completion in
//            switch completion {
//            case .success(let data):
//                defaultValue = UIImage(data: data) ?? UIImage(systemName: "xmark")!
//                completed(defaultValue)
//            case .failure(let error):
//                print(JsonError.failedRequest)
//            }
//        }
        self.request.fetchDataCombine(url, defaultValue: defaultValue) { data in
            let image = UIImage(data: data)
            completed(image!) // we can force unwrap as we providing a default image in case of error
                
            }
    }
}
