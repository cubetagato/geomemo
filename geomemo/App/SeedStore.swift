//
//  SeedStore.swift
//  geomemo
//
//  Created by Gabriel I. Hernández G. on 22/04/17.
//  Copyright © 2017 Gabriel I. Hernández G. All rights reserved.
//

import UIKit

class SeedStore {
    
    let cache = NSCache<NSString, Seed> ()
    
    func setSeed (_ seed: Seed, forKey key: String)   {
        cache.setObject(seed, forKey: key as NSString)
    }
    
    func seed (forKey key: String) -> Seed?  {
        return cache.object(forKey: key as NSString)
    }
    
    func deleteSeed (forKey key: String)    {
        cache.removeObject(forKey: key as NSString)
    }

}
