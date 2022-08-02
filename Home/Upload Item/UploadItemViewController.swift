//
//  UploadItemViewController.swift
//  MyDaangnMarket
//
//  Created by 유현진 on 2022/07/28.
//

import UIKit

class UploadItemViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var wonLabel: UILabel!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    var viewModel = NewItemViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initCollectionView()
    }
    // MARK: TODO
    // 카테고리 선택
    // - 카테고리 선택 화면 이동 O
    // - 선택한 적 있다면 tableView 표시하기 O
    // navigation bar
    // - 뒤로가기
    // 가격
    // - 수정 시에 wonLabel 색상 변경
    // - 1000 단위로 "," 구분
    // contentTextView
    // - placeholder 기능
    // - 카테고리에 따라 placeholder 내용 변경하기
    //
    
    
    
    @IBAction func categoryButton(_ sender: Any) {
        guard let vc = UIStoryboard(name: "Category", bundle: nil).instantiateViewController(withIdentifier: "categoryStoryboard") as? CategoryViewController else{
            return
        }
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
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
        return viewModel.selectedImageNumOfSection + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addImages", for: indexPath) as? addImagesCollectionViewCell else{
                return UICollectionViewCell()
            }
            cell.delegate = self
            cell.updateUI(count: viewModel.selectedImageNumOfSection)
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

extension UploadItemViewController: selectCategoryDelegate{
    func selectCategory(category: String) {
        self.viewModel.category = category
        self.categoryTitle.text = self.viewModel.category
    }
}
