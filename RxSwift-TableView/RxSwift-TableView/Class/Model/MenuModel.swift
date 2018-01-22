//
//  CustomModel.swift
//  RxSwift-TableView
//
//  Created by yaxun on 2018/1/22.
//  Copyright © 2018年 yaxun. All rights reserved.
//

import UIKit
import ObjectMapper
import RxDataSources

struct ThemeModel : Mappable {
    
    var limit : Int = 1000
    var subscripted : [MenuModel] = []
    var others : [MenuModel] = []
    
    mutating func mapping(map: Map) {
        subscripted         <- map["subscripted"]
        limit               <- map["limit"]
        others               <- map["others"]
        
    }
    
    init?(map: Map) {
        
    }
    
    
}

struct MenuModel : Mappable {
    
    var id        : Int = 0
    var des       : String = ""
    var name      : String = ""
    var color     : String = ""
    var thumbnail : String = ""
    var left      : String = ""
    var collect   : Bool   = false
    
    
    mutating func mapping(map: Map) {
        color       <- map["color"]
        des         <- map["description"]
        id          <- map["id"]
        name        <- map["name"]
        thumbnail   <- map["thumbnail"]
        left        <- map["left"]
        collect     <- map["collect"]
        
    }
    
    init?(map: Map) {
        
        mapping(map: map)
        
    }
    
}

