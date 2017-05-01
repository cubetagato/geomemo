//
//  Constants.swift
//  geomemo
//
//  Created by Gabriel I. Hernández G. on 17/04/17.
//  Copyright © 2017 Gabriel I. Hernández G. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    struct SYSTEM {
        
        static let VERSION: String = UIDevice.current.systemVersion
        static let VERSION_IS_9_OR_HIGHER: Bool = floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_9_0
        
    }
    
    struct APP  {
        
        struct TABBAR   {
        
            static let TAB_MAP_VIEW_TAG: Int = 1
            static let TAB_SEED_VIEW_TAG: Int = 2
            static let TAB_SETUP_VIEW_TAG: Int = 3
        
            static let TAB_DEFAUL_SELECTED_INDEX: Int = 1
        
            static let TAB_MAP_ICON_NAME: String = "compass"
            static let TAB_SEED_ICON_NAME: String = "placeholder"
            static let TAB_SETUP_ICON_NAME: String = "settings"
            
        }
    }
}
