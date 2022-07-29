//
//  addImagesCollectionViewCell.swift
//  MyDaangnMarket
//
//  Created by 유현진 on 2022/07/29.
//

import UIKit
import PhotosUI
protocol addImageDelegate{
    func addImagesToViewModel(image: UIImage)
}

class addImagesCollectionViewCell: UICollectionViewCell, PHPickerViewControllerDelegate {
    @IBOutlet weak var imageCount: UILabel!
    
    var delegate: UploadItemViewController?
    var itemProviders: [NSItemProvider] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func addImagesButton(_ sender: Any) {
        var phConf = PHPickerConfiguration()
        phConf.selectionLimit = 10
        phConf.filter = .any(of: [.images])
        
        let pickerVC = PHPickerViewController(configuration: phConf)
        pickerVC.delegate = self
        pickerVC.modalPresentationStyle = .fullScreen
        delegate?.present(pickerVC, animated: true, completion: nil)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        delegate?.viewModel.selectedImage.removeAll()
        itemProviders.removeAll()
        itemProviders = results.map(\.itemProvider)
        
        for item in itemProviders{
            if item.canLoadObject(ofClass: UIImage.self){
                item.loadObject(ofClass: UIImage.self) { image, error in
                    guard let image = image as? UIImage else {
                        return
                    }
                    self.delegate?.addImagesToViewModel(image: image)
                }
            }
        }
    }
    func updateUI(count: Int){
        self.imageCount.text = "\(count)/10"
    }
}

