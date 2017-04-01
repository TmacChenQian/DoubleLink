//
//  CQLeftGoodsCell.swift
//  DoubleLink
//
//  Created by 陈乾 on 2017/3/30.
//  Copyright © 2017年 Cha1ien. All rights reserved.
//

import UIKit

class CQLeftGoodsCell: UITableViewCell {

    
    lazy var nameLable : UILabel = UILabel()
    lazy var yellowView : UIView = UIView()
    
    var nameStr : String? {
        didSet{
            guard let nameStr = nameStr else {
                return
            }
            nameLable.text = nameStr
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        contentView.addSubview(yellowView)
        contentView.addSubview(nameLable)
        
        yellowView.backgroundColor = UIColor.yellow
        nameLable.numberOfLines = 0
        nameLable.font = UIFont.systemFont(ofSize: 16)
        nameLable.textColor = UIColor(130, 130, 130)
        nameLable.highlightedTextColor = UIColor(253, 212, 49)

        
        yellowView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(10)
            make.height.equalTo(42)
            make.left.equalTo(contentView)
            make.width.equalTo(3.5)
        }
        
        nameLable.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(10)
            make.height.equalTo(40)
            make.left.equalTo(yellowView.snp.right)
            make.width.equalTo(60)
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.backgroundColor = selected ? UIColor.white : UIColor(223, 223, 223)
        self.isHighlighted = selected
        self.nameLable.isHighlighted = selected
        self.yellowView.isHidden = !selected
    }

}
