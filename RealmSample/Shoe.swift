//
//  Shoe.swift
//  RealmSample
//
//  Created by Hank.Lee on 19/06/2019.
//  Copyright © 2019 hyeongkyu. All rights reserved.
//

import UIKit
import RealmSwift

class Shoe: Object {
    @objc dynamic var name: String?
    @objc dynamic var color: String?
    @objc dynamic var size = 0
    
    convenience init(name: String?, color: String?, size: Int) {
        self.init()
        self.name = name
        self.color = color
        self.size = size
    }
}
