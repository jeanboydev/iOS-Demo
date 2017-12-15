//
//  UserModel.swift
//  CoreDataTest
//
//  Created by jeanboy on 2017/12/14.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import Foundation
import RealmSwift

class UserModel: Object {
    
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var username = ""
    @objc dynamic var password = ""
    @objc dynamic var age = 0
    @objc dynamic var createTime = NSDate()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
