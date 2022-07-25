//
//  HomeViewController.swift
//  MyDaangnMarket
//
//  Created by 유현진 on 2022/07/25.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        // Do any additional setup after loading the view.
        registerCellNib()
        registerTopBarNib()
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
