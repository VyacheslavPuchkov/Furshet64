//
//  StorageService.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 05.12.2023.
//

import Foundation
import FirebaseStorage
import UIKit

class StorageService {
    static let shared = StorageService(); private init() { }
    let storage = Storage.storage().reference()
    
    var typeProductRef: StorageReference { storage.child("imageTypeProduct") }
    var productRef: StorageReference { storage.child("imageProduct") }
    
    func dowloadPicture(picName: String, ref: StorageReference, completion: @escaping([UIImage]) -> ()) {
        var image: UIImage = UIImage(named: "productFoto")!
        var images: [UIImage] = []
        let fileRef = ref.child(picName)
        fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
            guard error == nil else {
                completion(images)
                return
            }
            image = UIImage(data: data!)!
            images.append(image)
            completion(images)
        }
    }
    
}
