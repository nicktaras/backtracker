//
//  Track.swift
//  BackTrack Mapper
//
//  Created by Nicholas Taras on 20/10/2016
//  Copyright © 2016 Nicholas Taras All rights reserved.
//  See LICENSE.txt for this sample’s licensing information.

import UIKit

class Track {
   
    var name: String
    var photo: UIImage?
    var type: String?
    var coords: String?
    var address: String?
    var timeStamp: String?
    
    init?(name: String, photo: UIImage? = nil, type: String? = nil, coords: String? = nil, address: String? = nil, timeStamp: String? = nil) {

        self.name = name
        self.photo = photo
        self.type = type
        self.coords = coords
        self.address = address
        self.timeStamp = timeStamp
        
    }
    
}