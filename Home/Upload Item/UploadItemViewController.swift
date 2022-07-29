//
//  UploadItemViewController.swift
//  MyDaangnMarket
//
//  Created by 유현진 on 2022/07/28.
//

import UIKit

class UploadItemViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel = NewItemViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initCollectionView()
    }
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
        
    func initCollectionView(){
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        let addImageNib = UINib(nibName: "addImagesCollectionViewCell", bundle: nil)
        self.collectionView.register(addImageNib, forCellWithReuseIdentifier: "addImages")
        let selectedImagesNib = UINib(nibName: "SelectedImagesCollectionViewCell", bundle: nil)
        self.collectionView.register(selectedImagesNib, forCellWithReuseIdentifier: "seletedImage")
        
    }

}

extension UploadItemViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numOfSection + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addImages", for: indexPath) as? addImagesCollectionViewCell else{
                return UICollectionViewCell()
            }
            cell.delegate = self
            cell.updateUI(count: viewModel.numOfSection)
            return cell
        }else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "seletedImage", for: indexPath) as? SelectedImagesCollectionViewCell else{
                return UICollectionViewCell()
            }

            cell.delegate = self
            cell.indexPath = indexPath.item - 1
            cell.updateUI(image: viewModel.selectedImage[indexPath.item - 1])
            return cell
        }
    }
}

extension UploadItemViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
}

extension UploadItemViewController: addImageDelegate{
    func addImagesToViewModel(image: UIImage) {
        self.viewModel.selectedImage.append(image)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }
    func deleteSelectedImage(index: Int){
        self.viewModel.selectedImage.remove(at: index)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
