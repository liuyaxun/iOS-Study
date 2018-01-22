//
//  MenuViewModel.swift
//  RxSwift-TableView
//
//  Created by yaxun on 2018/1/22.
//  Copyright © 2018年 yaxun. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import ObjectMapper
import Moya

class MenuViewModel : NSObject {
    let bag = DisposeBag()
    let provider = MoyaProvider<ApiService>()
    
    
    var menuModels  = Variable<[SectionModel<String,MenuModel>]>.init([SectionModel<String,MenuModel>.init(model: "Menu", items: [MenuModel.init(map: Map.init(mappingType: .fromJSON, JSON: ["name":"首页","left":"Menu_Icon_Home"],toObject: true))!])])
    
    override init() {
        super.init()
        loadMenuThemes()
    }
    
    func loadMenuThemes() {
        provider.rx.request(.home_data).mapObject(ThemeModel.self).subscribe(onSuccess: { (data) in
            self.menuModels.value.append(SectionModel<String,MenuModel>.init(model: "Menu", items: data.others))
            
        }, onError: nil).disposed(by: bag)
    }
    
}

