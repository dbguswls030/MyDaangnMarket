//
//  CategoryTableViewCell.swift
//  MyDaangnMarket
//
//  Created by 유현진 on 2022/08/02.
//

import UIKit
class CategoryTableViewCell: UITableViewCell {

//    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var checkMark: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(category: String){
        self.category.text = category
        self.checkMark.isHidden = true
    }
    func updateUIWithHighlight(category: String){
        self.category.text = category
        self.category.textColor = .orange
        self.checkMark.isHidden = false
    }
    
}
