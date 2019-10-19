//
//  FoodDatas.swift
//  foodnotepad
//
//  Created by iOS on 2019/10/3.
//  Copyright © 2019 Xphuang. All rights reserved.
//

import Foundation
class DatailsOfFoodData{
    var name:String
    var number:String
    var store:String
    //var imageName:String
    init() {
        name = "无"
        number = "无"
        store = "无"
        //imageName = "NoPhoto"
    }
    init(na:String,num:String,st:String,imn:String) {
        name = na
        number = num
        store = st
        //imageName = imn
    }
    deinit {
        
    }
}
//class FoodData{
//    var detailsOfFoodDatas:Array<DatailsOfFoodData> = [DatailsOfFoodData]()
//    init() {
//        detailsOfFoodDatas.append(DatailsOfFoodData())
//    }
//    init(details:[DatailsOfFoodData]) {
//        detailsOfFoodDatas = details
//    }
//    deinit {
//    }
//}
