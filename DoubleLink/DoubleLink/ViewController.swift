//
//  ViewController.swift
//  DoubleLink
//
//  Created by 陈乾 on 2017/3/29.
//  Copyright © 2017年 Cha1ien. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    
    
    //MARK: - 懒加载
    lazy var scrollView : UIScrollView = {
        let sc = UIScrollView()
        sc.isPagingEnabled = true
        sc.delegate = self
        sc.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        sc.bounces = false
        return sc;
        
    }()
    
    lazy var topHeadView :UIView = {
        let tpv = UIView()
        tpv.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)

        return tpv;
    }()
    
    lazy var sliderView :CQSliderView = {
        let slv = CQSliderView()
        slv.backgroundColor = UIColor(154,130,145)
        return slv;
    }()
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.navigationBar.isTranslucent = true
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        setupUI()
        
    }
    
   
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //隐藏Nav
        navigationController?.navigationBar.alpha = 0.1
   
    }
    
    
    //MARK: - 设置UI
     func setupUI() {
        //添加
        view.addSubview(topHeadView)
        view.addSubview(sliderView)
        view.addSubview(scrollView)
        //约束
        topHeadView.snp.makeConstraints { (make) in
            make.height.equalTo(KTopHeadHeight)
            make.top.equalTo(view).offset(0)
            make.left.right.equalTo(view)
        }
        sliderView.snp.makeConstraints { (make) in
            make.height.equalTo(KSliderViewHeight)
            make.top.equalTo(topHeadView.snp.bottom)
            make.left.right.equalTo(view)
        }
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(sliderView.snp.bottom)
            make.left.right.bottom.equalTo(view)
        }
        
        //给sliderView添加valueChange事件
        sliderView.addTarget(self, action: #selector(changeScrollView), for: UIControlEvents.valueChanged)
        //逻辑
        //TODO:利用反射 创建控制器，设置跟控制器
        let vcArr = ["CQGoodsListController","CQStoreListController","CQMarketListController"]
        let rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: scrollView.bounds.size.height)
        
        for (indx,vcStr) in vcArr.enumerated(){
            
            guard let cls = NSClassFromString(Bundle.main.nameSpace + "." + vcStr) as? UIViewController.Type  else {
                return
            }
           let vc = cls.init()
            vc.view.frame = rect.offsetBy(dx: CGFloat(indx) * screenWidth, dy: 0)
           //父子控制器 父子view 添加格式
           self.addChildViewController(vc)
           scrollView.addSubview(vc.view)
           vc.didMove(toParentViewController: self)
 
        }
        //设置滚动范围
        scrollView.contentSize = CGSize(width: screenWidth * CGFloat(vcArr.count), height: 0)
        //添加拖拽手势
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panGestureRec))
        pan.delegate = self
        
        self.view.addGestureRecognizer(pan)
        
    }
    
    //MARK: -CQSliderView的tag值改变的时候来调用 来滚动scrollView
    func changeScrollView(sender: CQSliderView){
    
        scrollView.setContentOffset(CGPoint(x: CGFloat(sender.tag) * screenWidth, y: 0), animated: true)
        
    }
    //MARK: - 拖拽的时候让scrollView上下滚动
    func panGestureRec(gesture: UIPanGestureRecognizer) {
        
        let point = gesture.translation(in: gesture.view)
        
        let height = topHeadView.frame.size.height + point.y
        
        gesture.setTranslation(CGPoint.zero, in: gesture.view)
        
        if height < 64 || height > 124  {
            return
        }
        
        topHeadView.snp.updateConstraints { (make) in
            make.height.equalTo(height)
        }
        //立即通知布局
        self.view.layoutIfNeeded()
        
        //可移动的高度
        let offsetHeight :CGFloat = 60.0
        
        //取出之前的alpha
        let oldAlpha:CGFloat = 0.0;
        
        //用当前移动的高度
        let alpha =  oldAlpha - point.y * 1.0 / offsetHeight;
        print(alpha)
        //设置给导航条
        self.navigationController?.navigationBar.alpha = alpha;
        
    }

}

extension ViewController : UIGestureRecognizerDelegate{
    //MARK: -多手势
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension ViewController:UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //说明是人为拖动
        if scrollView.isDragging || scrollView.isTracking || scrollView.isDecelerating{
            
            let offsetX = scrollView.contentOffset.x/3
            
            sliderView.offsetX = offsetX
        }
    }

}


