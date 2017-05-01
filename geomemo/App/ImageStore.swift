//
//  ImageStore.swift
//  geomemo
//
//  Created by Gabriel I. Hernández G. on 22/04/17.
//  Copyright © 2017 Gabriel I. Hernández G. All rights reserved.
//

import UIKit

class ImageStore {
    
    let cache = NSCache<NSString, UIImage> ()
    
    func setImage (_ image: UIImage, forKey key: String)    {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func image (forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func deleteImage (forKey key: String)   {
        cache.removeObject(forKey: key as NSString)
    }

}
