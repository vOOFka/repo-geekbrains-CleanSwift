//
//  ProductDetailsViewController.swift
//  shopVS
//
//  Created by Home on 03.04.2022.
//

import UIKit
import PinLayout

class ProductDetailsViewController: UIViewController {
    // MARK: - Public properties
    var productViewModel: GoodsViewCellModel?
    var feedbackViewModel: FeedbackViewCellModel?
    
    // MARK: - Private properties
    private var tableView = UITableView()
    private let appService = AppService()
     
    // MARK: - Init & Lifecycle
    init(productViewModel: GoodsViewCellModel) {
        self.productViewModel = productViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(GoodsTableViewCell.self)
        
        layoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutSubviews()
    }
    
    private func layoutSubviews() {
        tableView.pin.all()
    }
}

// MARK: - Table view
extension ProductDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int { 2 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let cell = tableView.dequeueReusableCell(GoodsTableViewCell.self, for: indexPath)
        
        guard let productViewModel = productViewModel else {
            return cell
        }
        
        switch section {
        case 0:
            cell.config(for: productViewModel)
            return cell
        case 1:
            return cell
        default:
            return cell
        }
    }
}
