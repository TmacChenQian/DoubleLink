//
//  CQRightGoodsCell.swift
//  DoubleLink
//
//  Created by 陈乾 on 2017/3/30.
//  Copyright © 2017年 Cha1ien. All rights reserved.
//

import UIKit
import SDWebImage

class CQRightGoodsCell: UICollectionViewCell {
    
    var model : CQSubcategoriesModel? {
        didSet{
            guard let icon_url = model?.icon_url,let nameStr = model?.name  else {
                return
            }
            imageV.sd_setImage(with: URL(string: icon_url))
            nameLabl.text = nameStr
        }
    }
    //MARK: - 懒加载
    lazy var imageV : UIImageView = {
        let imgV = UIImageView()
        return imgV
    }()
    
    
    lazy var nameLabl : UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.textColor = UIColor.gray
        lb.textAlignment = .center
        return lb
    }()
    
    
    //MARK: - 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        contentView.addSubview(imageV)
        contentView.addSubview(nameLabl)
        //约束
        imageV.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-20)
        }
        nameLabl.snp.makeConstraints { (make) in
            make.top.equalTo(imageV.snp.bottom)
            make.bottom.left.right.equalTo(contentView)
        }
    }
    
}
