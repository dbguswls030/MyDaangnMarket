//
//  ItemViewModel.swift
//  MyDaangnMarket
//
//  Created by 유현진 on 2022/07/29.
//

import Foundation
import UIKit
class NewItemViewModel{
    var newItem = NewItem()
    
    var title: String{
        didSet{
            newItem.title = title
        }
    }
    var content: String{
        didSet{
            newItem.content = content
        }
    }
    var category: String{
        didSet{
            newItem.category = category
        }
    }
    var price: Int{
        didSet{
            newItem.price = price
        }
    }
    var selectedImage: [UIImage]
    
    var numOfSection: Int{
        get{
            return selectedImage.count
        }
    }
    
    let categoryArray: [String] = ["디지털기기", "생활가전", "가구/인테리어", "유아동", "유아도서", "생활/가공식품", "스포츠/레저", "여성잡화", "여성의류", "남성패션/잡화", "게임/취미", "뷰티/미용", "반려동물용품", "도서/티켓/음반", "식물", "기타 중고물폽", "삽니다"]
    
    init(){
        self.selectedImage = [UIImage]()
        self.title = ""
        self.price = 0
        self.content = ""
        self.category = ""
    }
}
