//
//  ApiService.swift
//  RxSwift-TableView
//
//  Created by yaxun on 2018/1/22.
//  Copyright © 2018年 yaxun. All rights reserved.
//

import UIKit
import Moya

enum ApiService : TargetType {
    
    case home_data
    
    var path: String {
        switch self {
        case .home_data:
            return "/themes"
        }
    }
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data.init(count: 1)
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    var baseURL: URL {
        return URL(string: "https://news-at.zhihu.com/api/4")!
    }
    
}
