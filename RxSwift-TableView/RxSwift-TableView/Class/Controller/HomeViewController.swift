//
//  HomeViewController.swift
//  RxSwift-TableView
//
//  Created by yaxun on 2018/1/22.
//  Copyright © 2018年 yaxun. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources


class HomeViewController: UIViewController {
    let bag = DisposeBag()
    // viewModel 的实例对象
    let viewModel = MenuViewModel()
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.register(MenuCell.self, forCellReuseIdentifier: "MenuCell")
        tv.separatorStyle = .none
        tv.backgroundColor = .black
        return tv
    }()
    /// tableView 的数据源初始化
    lazy var dataSource : RxTableViewSectionedReloadDataSource<SectionModel<String,MenuModel>> = {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String,MenuModel>>(configureCell: { source, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
            cell.model = item
            cell.focusSubject.subscribe { (event) in
                guard let ele = event.element else { return }
                let sectionModels = self.dataSource.sectionModels.first
                guard let index = self.tableView.indexPath(for: cell) else { return }
                if index.row == 0 && index.section == 0 { return }
                self.tableView.moveRow(at: index, to: IndexPath.init(row: 0, section: 1))
                }.disposed(by: self.bag)
            return cell
        },canMoveRowAtIndexPath:{ (dataSource,indexPath) -> Bool in
            return true
        })
        return dataSource
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        blindViewModel()
    }


}

extension HomeViewController {
    
    func setupUI()  {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    
    func blindViewModel() {
        /*
         public func bind<R>(to binder: (Self) -> R) -> R {
         return binder(self)
         }
         */
        
        viewModel
            .menuModels
            .asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by:bag)
        
        
        tableView.rx.itemSelected.subscribe { event in
            guard let index = event.element else { return }
            let sectionModel = self.dataSource.sectionModels[index.section]
            let model = sectionModel.items[index.row]
            print("选中了 " + model.name)
            }.disposed(by: bag)
        
    }
    
    
    
    
}
