//
//  Bundle+Extension.swift
//  DoubleLink
//
//  Created by 陈乾 on 2017/3/29.
//  Copyright © 2017年 Cha1ien. All rights reserved.
//

import UIKit

extension Bundle{
    var nameSpace : String {
        return  Bundle.main.infoDictionary!["CFBundleName"] as! String
    }
    
    
    
}
