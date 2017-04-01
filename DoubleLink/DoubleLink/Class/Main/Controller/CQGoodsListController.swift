//
//  CQGoodsListController.swift
//  DoubleLink
//
//  Created by 陈乾 on 2017/3/29.
//  Copyright © 2017年 Cha1ien. All rights reserved.
//

import UIKit

class CQGoodsListController: UIViewController {
    
    
    //MARK: - 懒加载
    //数据源
    fileprivate lazy var categoriseModelArr = [CQCategoriesModel]()
    fileprivate lazy var subCategoriseModelArr = [[CQSubcategoriesModel]]()
    
    fileprivate var isDownScroll : Bool = true
    fileprivate var selectedIndex : Int = 0
    fileprivate var lastOffsetY : CGFloat = 0.0
    
    //tableview
    fileprivate lazy var leftTabelView :UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: KLeftTableViewWidth, height: screenHeight - KTopHeadHeight - KSliderViewHeight))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 55
        tableView.register(CQLeftGoodsCell.self, forCellReuseIdentifier: KLeftCellReuseID)
        tableView.separatorColor = UIColor.clear
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    //flowLayout
    fileprivate lazy var flowLayout: UICollectionViewFlowLayout = {
        let fl = UICollectionViewFlowLayout()
        fl.itemSize = CGSize(width: (screenWidth - KLeftTableViewWidth)/3, height: (screenWidth - KLeftTableViewWidth)/3 + 30)
        fl.headerReferenceSize = CGSize(width:screenWidth - KLeftTableViewWidth , height: 30)
        fl.minimumLineSpacing = 0
        fl.minimumInteritemSpacing = 0
        fl.scrollDirection = .vertical
        return fl
    }()
    //collectionView
    fileprivate lazy var rightCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: KLeftTableViewWidth, y: 0, width: screenWidth - KLeftTableViewWidth , height: screenHeight - KTopHeadHeight -  KSliderViewHeight), collectionViewLayout: self.flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(CQRightGoodsCell.self, forCellWithReuseIdentifier: KRightCollectViewCellReuseID)
        collectionView.register(CQRightGoodsHeaderView.self,forSupplementaryViewOfKind:UICollectionElementKindSectionHeader,withReuseIdentifier:KRightCollectViewCellHeaderReuseID)
        return collectionView
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
        self.view.backgroundColor = UIColor.white
        //选中第一行
        leftTabelView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: UITableViewScrollPosition.middle)
        
    }
    
    //MARK: - 加载数据
    func loadData(){
        
        CQCategoriesViewModel.shareManger.loadCollectionViewData { (modeArr) in
            guard let modeArr = modeArr else{return}
            self.categoriseModelArr = modeArr
            for model in modeArr{
                subCategoriseModelArr.append(model.subcategories!)
            }
  
            leftTabelView.reloadData()
            rightCollectionView.reloadData()
        }
        
    }
    
    
    // MARK: - 设置UI
    func setupUI(){
        self.view.addSubview(leftTabelView)
        self.view.addSubview(rightCollectionView)
    }
    
    
    
}

extension CQGoodsListController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriseModelArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: KLeftCellReuseID, for: indexPath) as? CQLeftGoodsCell
        let model = categoriseModelArr[indexPath.row]
        cell?.nameStr = model.name
        return cell!
    }
    
    //MARK: - 点击cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionIndx = indexPath.row
        
        rightCollectionView.scrollToItem(at: IndexPath(item: 0, section: sectionIndx), at: UICollectionViewScrollPosition.top, animated: true)
        tableView.scrollToRow(at: IndexPath(row: sectionIndx, section: 0), at: .top, animated: true)
    }
    
}

extension CQGoodsListController : UICollectionViewDataSource,UICollectionViewDelegate{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return categoriseModelArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(subCategoriseModelArr[section].count)
        return subCategoriseModelArr[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cvCell = collectionView.dequeueReusableCell(withReuseIdentifier: KRightCollectViewCellReuseID, for: indexPath) as? CQRightGoodsCell
        
        let model = subCategoriseModelArr[indexPath.section][indexPath.row]
        
        cvCell?.model = model
        
        return cvCell!
    }
    
    ///返回头部视图
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KRightCollectViewCellHeaderReuseID, for: indexPath) as? CQRightGoodsHeaderView
        
        if kind == UICollectionElementKindSectionHeader {
            //设置数据
            let model = categoriseModelArr[indexPath.section]

            headView?.nameStr = model.name
        }
        
        return headView!
        
    }
    
    //MARK: - 即将展示标题
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        
        if !isDownScroll && collectionView.isDragging {
           selectedLeftTableRow(row: indexPath.section)
        }
        
    }
    
    ////MARK: -标题展结束
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        
        if isDownScroll && collectionView.isDragging {
            selectedLeftTableRow(row: indexPath.section + 1)

        }
    }
    
    func selectedLeftTableRow(row : Int){
        
        leftTabelView.selectRow(at: IndexPath(row: row, section: 0), animated: true, scrollPosition: UITableViewScrollPosition.middle)
        
    }
    //MARK: - 判断滚动方向
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
        if scrollView == rightCollectionView {
            isDownScroll = lastOffsetY < scrollView.contentOffset.y
            lastOffsetY = scrollView.contentOffset.y
        }
        
    }
    
    
}


