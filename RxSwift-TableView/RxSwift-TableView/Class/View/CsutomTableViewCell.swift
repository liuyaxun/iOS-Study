//
//  CsutomTableViewCell.swift
//  RxSwift-TableView
//
//  Created by yaxun on 2018/1/22.
//  Copyright © 2018年 yaxun. All rights reserved.
//

import UIKit
import Foundation
import RxCocoa
import RxSwift
import SnapKit


public class MenuCell : UITableViewCell {
    
    let focusSubject : PublishSubject<MenuModel> = PublishSubject<MenuModel>.init()
    let bag = DisposeBag()
    
    let homeImageView : UIImageView = {
        let image = UIImageView.init()
        image.image = UIImage.init(named: "Menu_Icon_Home")
        return image
    }()
    let label : UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .red
        return label
    }()
    let actorBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: "Menu_Actor"), for: .normal)
        return btn
    }()
    
    var model : MenuModel? {
        didSet {
            label.text = model?.name
            if model?.left != "" { // 首页
                let have = subviews.contains(homeImageView)
                if !have {
                    addSubview(homeImageView)
                }
                homeImageView.snp.makeConstraints({ (make) in
                    make.left.equalToSuperview().offset(15)
                    make.centerY.equalToSuperview()
                })
                label.snp.remakeConstraints({ (make) in
                    make.left.equalTo(homeImageView.snp.right).offset(15)
                    make.centerY.equalToSuperview()
                })
            }else {
                let have = subviews.contains(homeImageView)
                if have {
                    homeImageView.removeFromSuperview()
                }
                label.snp.remakeConstraints({ (make) in
                    make.left.equalToSuperview().offset(15)
                    make.centerY.equalToSuperview()
                })
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        selectionStyle = .none
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func setSelected(_ selected: Bool, animated: Bool) {
        
        if selected {
            label.textColor = .white
            backgroundColor = .black
            if subviews.contains(homeImageView) {
                homeImageView.image = UIImage.init(named: "Menu_Icon_Home")
            }
        }else {
            label.textColor = .white
            backgroundColor = .black
            if subviews.contains(homeImageView) {
                homeImageView.image = UIImage.init(named: "Menu_Icon_Home")
            }
        }
    }
    
}

extension MenuCell {
    
    fileprivate func setupUI() {
        addSubview(label)
        addSubview(actorBtn)
        addSubview(homeImageView)
        
        label.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        })
        actorBtn.snp.makeConstraints({ (make) in
            make.right.equalToSuperview().offset(-36)
            make.centerY.equalToSuperview()
        })
        
        actorBtn.rx.controlEvent([.touchUpInside]).subscribe({ (event) in
            if (self.model?.collect)! { return }
            self.focusSubject.onNext(self.model!)
            UIView.animate(withDuration: 0.5, animations: {
                self.actorBtn.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
                self.actorBtn.alpha = 0.2
            }, completion: { (finish) in
                UIView.animate(withDuration: 0.5, animations: {
                    self.actorBtn.setImage(UIImage.init(named: "Menu_Actor"), for: .normal)
                    self.actorBtn.transform = CGAffineTransform.identity
                    self.actorBtn.alpha = 1
                })
            })
            self.model?.collect = true
        }).disposed(by: bag)
        
    }
}

