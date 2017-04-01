//
//  CQRightGoodsHeaderView.swift
//  DoubleLink
//
//  Created by 陈乾 on 2017/3/30.
//  Copyright © 2017年 Cha1ien. All rights reserved.
//

import UIKit
class CQRightGoodsHeaderView: UICollectionReusableView {
    
    var nameStr : String? {
        didSet{
            guard let nameStr = nameStr  else {
                return
            }
            nameLab.text = nameStr
        }
    }
    
    lazy var nameLab : UILabel = {
       let lb = UILabel()
        lb.numberOfLines = 0
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.textColor = UIColor.red
        lb.textAlignment = .center
       return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(224, 224, 224, 0.6)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        self.addSubview(nameLab)
        nameLab.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    
    }
    
}
