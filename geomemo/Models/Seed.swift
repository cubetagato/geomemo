//
//  Seed.swift
//  geomemo
//
//  Created by Gabriel I. Hernández G. on 22/04/17.
//  Copyright © 2017 Gabriel I. Hernández G. All rights reserved.
//

import UIKit

class Seed: NSObject {
    
    enum SeedType   {
        case image, video, audio, message
    }
    
    var id: String
    var seedDate: Date
    var seedType: SeedType?
    var from: String?
    var to: String?
    
    init( seedType: SeedType?, from: String?, to: String?) {
        
        self.id = UUID().uuidString
        self.seedDate = Date()
        self.seedType = seedType
        self.from = from
        self.to = to
        
        super.init()

    }
    
    convenience init(seedType: SeedType) {
        
        self.init(seedType: seedType, from: nil, to: nil)
        
    }
    
    convenience override init() {
        self.init(seedType: nil, from: nil, to: nil)
    }

}
