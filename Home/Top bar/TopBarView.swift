//
//  TopBarView.swift
//  MyDaangnMarket
//
//  Created by 유현진 on 2022/07/25.
//

import UIKit

class TopBarView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
//         initNib()
    }
    required init?(coder: NSCoder){
        super.init(coder: coder)
//         initNib()
    }
    func initNib(){
        if let view = UINib(nibName: "TopBar", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView {
            view.frame = self.bounds
            addSubview(view)
        }
    }
}
