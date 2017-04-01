//
//  CQSliderView.swift
//  DoubleLink
//
//  Created by 陈乾 on 2017/3/29.
//  Copyright © 2017年 Cha1ien. All rights reserved.
//

import UIKit

class CQSliderView: UIControl {

    lazy var btnList: [UIButton] = {
        let arr = [UIButton]()
        return arr
    }()
    
    var selectedBtn : UIButton?
    
    var lineView: UIView?
    
    var offsetX : CGFloat?  {
        didSet{
            //当外界的值改变的时候，让下面的线更新UI，选中对应的按钮
            if let offsetX = offsetX{
                lineView?.snp.updateConstraints({ (make) in
                    make.left.equalTo(self).offset(offsetX)
                })
                //立马通知布局
                self.layoutIfNeeded()
                let idx = Int(offsetX / (lineView?.bounds.size.width)!)
                
                selectedBtn?.isSelected = false
                btnList[idx].isSelected = true
                selectedBtn = btnList[idx]
         
            }
        }
    }
    
   override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){

        let buttonTitle = ["商品","商铺","超市购"];
        let width = UIScreen.main.bounds.size.width/CGFloat(buttonTitle.count)
        let rect = CGRect(x: 0, y: 0, width: width, height: 42)
        //创建
        for (idx,str) in buttonTitle.enumerated(){
            //便利构造函数
            let sliderButton = UIButton(title: str, titleColor: UIColor.black, fontSize: 15, image: nil, bgImage: nil, target: self, selector: #selector(changeCategory), event: UIControlEvents.touchUpInside)
            sliderButton.setTitleColor(UIColor.yellow, for: .selected)
            //给tag
            sliderButton.tag = idx
            sliderButton.frame = rect.offsetBy(dx: width * CGFloat(idx), dy: 0)
            //添加
            self.addSubview(sliderButton)
            btnList.append(sliderButton)
        }
        
        //下面的条
        lineView = UIView()
        lineView?.backgroundColor = UIColor.yellow;
        self.addSubview(lineView!)
        lineView?.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(self)
            make.width.equalTo(btnList[0])
            make.height.equalTo(2);
        }
        
        //选中第一个按钮
        btnList[0].isSelected = true
        selectedBtn = btnList[0]
        
        
        
        
    }

    //MARK: - 按钮点击
    func changeCategory(btn: UIButton){
        //让按钮反选中
        selectedBtn?.isSelected = false
        btn.isSelected = true
        selectedBtn = btn
        //让下面的线滚动
        let offsetX : CGFloat = CGFloat(btn.tag) * (lineView?.bounds.size.width)!
        lineView?.snp.updateConstraints({ (make) in
            make.left.equalTo(self).offset(offsetX)
        })
        
        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
        }
        
        //外界监听这个来控制下面的scrollView滚动
        self.tag = btn.tag
        //添加valueChanged事件
        self.sendActions(for: .valueChanged)

    
    }
    
}
