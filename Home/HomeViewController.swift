//
//  HomeViewController.swift
//  MyDaangnMarket
//
//  Created by 유현진 on 2022/07/25.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
class HomeViewController: UIViewController {

    @IBOutlet weak var uploadItemButton: UIButton!
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var collectionView: UICollectionView!

    let db = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        // Do any additional setup after loading the view.
        registerCellNib()
        registerTopBarNib()
        inituploadItemButtonStyle()
    }
    func inituploadItemButtonStyle(){
        self.uploadItemButton.layer.cornerRadius = self.uploadItemButton.bounds.width/2
    }
    @IBAction func upLoadItemButton(_ sender: Any) {
//        let firebaseAuth = Auth.auth()
//        do {
//            try firebaseAuth.signOut()
//        } catch let signOutError as NSError {
//            print("Error signing out: %@", signOutError)
//        }
        let vc = UIStoryboard(name: "UploadItem", bundle: nil).instantiateViewController(withIdentifier: "UploadItemStoryboard")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func registerTopBarNib(){
        guard let topBarNib = Bundle.main.loadNibNamed("TopBar", owner: self, options: nil)?.first as? TopBarView else{
            return
        }
        topBarNib.frame = CGRect(x: 0, y: 0, width: self.topBar.frame.width, height: self.topBar.frame.height)
        topBarNib.initNib()
        self.topBar.addSubview(topBarNib)
    }
}
extension HomeViewController: UICollectionViewDataSource{
    func registerCellNib(){
        let cellNib = UINib(nibName: "ItemListCollectionViewCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "itemListCell")
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemListCell", for: indexPath) as? ItemListCollectionViewCell else{
            return UICollectionViewCell()
        }
        return cell
    }
    
    
}
extension HomeViewController: UICollectionViewDelegate{
    
}
extension HomeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width
        let height = CGFloat(150)
        return CGSize(width: width, height: height)
    }
}
