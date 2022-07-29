//
//  SelectImagesCollectionViewCell.swift
//  MyDaangnMarket
//
//  Created by 유현진 on 2022/07/28.
//

import UIKit

class SelectedImagesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var pickedImage: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    
    var delegate: UploadItemViewController?
    var indexPath: Int?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        delegate?.deleteSelectedImage(index: indexPath!)
    }
    
    func updateUI(image: UIImage){
        DispatchQueue.main.async {
            self.pickedImage.image = image
            self.deleteButton.layer.cornerRadius = self.deleteButton.bounds.width/2
            self.pickedImage.layer.cornerRadius = 2
        }
    }
}
