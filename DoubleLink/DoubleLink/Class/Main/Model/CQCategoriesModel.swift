//
//  CQCategoriesModel.swift
//  DoubleLink
//
//  Created by 陈乾 on 2017/3/30.
//  Copyright © 2017年 Cha1ien. All rights reserved.
//

import UIKit
import YYModel
class CQCategoriesModel: NSObject {

    var name : String?
    
    var subcategories : [CQSubcategoriesModel]?

    
    class func modelContainerPropertyGenericClass () -> [String: Any] {
        return ["subcategories": CQSubcategoriesModel.self]
    }
    
    override var description: String{
     
        return yy_modelDescription()
    }

}


class CQSubcategoriesModel: NSObject {
    
    var name : String?
    
    var icon_url : String?
    
    override var description: String{
        
      return yy_modelDescription()
    }

}
