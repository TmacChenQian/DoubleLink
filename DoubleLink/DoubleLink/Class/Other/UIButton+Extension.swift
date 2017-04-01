//
//  UIButton+Extension.swift
//  DoubleLink
//
//  Created by 陈乾 on 2017/3/29.
//  Copyright © 2017年 Cha1ien. All rights reserved.
//

import UIKit


extension UIButton{

    //MARK: - 按钮的便利构造函数
    convenience init(title: String?,titleColor : UIColor? = UIColor.black,fontSize: CGFloat? = 13,image:String?=nil,bgImage:String?=nil,target:Any? = nil,selector:Selector?=nil,event:UIControlEvents? = .touchUpInside) {
        self.init()
        if let title = title{
          self.setTitle(title, for: .normal)
          self.setTitleColor(titleColor, for: .normal)
          self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize!)
        }
        if let image = image {
            self.setImage(UIImage(named: image), for: .normal)
        }
        if let bgImage = bgImage {
          self.setBackgroundImage(UIImage(named: bgImage), for: .normal)
        }
        if let target = target,let selector = selector{
          self.addTarget(target, action: selector, for: event!)
        }
    }

}
