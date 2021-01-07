//
//  Photos.swift
//  Catapult
//
//  Created by Alison Soong on 1/6/21.
//

import UIKit

class Photos {
    
    //MARK: Properties
    var name: String
    var photo: UIImage?
    
    //MARK: Initialization
    init?(name: String, photo: UIImage?) {
        if (name.isEmpty)  {
            return nil
        }
        
        self.name = name
        self.photo = photo
    }
    
}


