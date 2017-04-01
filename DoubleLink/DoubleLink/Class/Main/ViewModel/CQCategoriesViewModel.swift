//
//  CQCategoriesViewModel.swift
//  DoubleLink
//
//  Created by 陈乾 on 2017/3/30.
//  Copyright © 2017年 Cha1ien. All rights reserved.
//

import UIKit

class CQCategoriesViewModel: NSObject {
    
    //单列
    static let shareManger:CQCategoriesViewModel = CQCategoriesViewModel()
    
    fileprivate override init(){
        super.init()
    }

    
    func loadCollectionViewData(loadDataCloseBack : (_ dataArr : [CQCategoriesModel]?)->()){
        
        guard let path = Bundle.main.path(forResource: "liwushuo.json", ofType: nil)  else {
            return
        }
        guard let data = NSData(contentsOfFile: path) as? Data else {
            return
        }
        
        guard let dic = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] else {
            return
        }
        
        guard let dataDic = dic?["data"] as? [String : Any]  else {
            return
        }
        
        guard let categoriesArr = dataDic["categories"] as? [[String : Any]]  else {
            return
        }
        
        //利用YYModel解析   + (nullable NSArray *)yy_modelArrayWithClass:(Class)cls json:(id)json;
        
        guard let categoriesModelArr = NSArray.yy_modelArray(with: CQCategoriesModel.self, json: categoriesArr) as? [CQCategoriesModel] else {
            return
        }
        
        //回调
        loadDataCloseBack(categoriesModelArr)
        
        
    }
    
    
}
