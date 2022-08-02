//
//  CategoryViewController.swift
//  MyDaangnMarket
//
//  Created by 유현진 on 2022/08/02.
//

import UIKit
protocol selectCategoryDelegate{
    func selectCategory(category: String)
}
class CategoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var delegate: UploadItemViewController?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initTableView()
    }
    func initTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        let categoryNib = UINib(nibName: "CategoryTableViewCell", bundle: nil)
        tableView.register(categoryNib, forCellReuseIdentifier: "categoryCell")
    }
}

extension CategoryViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.viewModel.categoryArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as? CategoryTableViewCell else{
            return UITableViewCell()
        }
        if let category = delegate?.viewModel.categoryArray[indexPath.row]{
            if delegate?.viewModel.category == category{
                cell.updateUIWithHighlight(category: category)
            }else{
                cell.updateUI(category: category)
            }
            
        }
        return cell
    }
}

extension CategoryViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let category = delegate?.viewModel.categoryArray[indexPath.row]{
            delegate?.selectCategory(category: category)
            self.dismiss(animated: true)
        }
    }
}
