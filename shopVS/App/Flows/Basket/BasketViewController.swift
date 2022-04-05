//
//  BasketViewController.swift
//  shopVS
//
//  Created by Home on 05.04.2022.
//

import UIKit
import PinLayout

class BasketViewController: UIViewController {
    // MARK: - Public properties
    var basketViewModel: BasketViewModel?
    
    // MARK: - Private properties
    private var basketInfoHolderView = UIView()
    private var tableView = UITableView()
    
    // MARK: - Init & Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(basketInfoHolderView)
        view.addSubview(tableView)
        
        basketInfoHolderView.backgroundColor = .link
        tableView.backgroundColor = .magenta
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        //tableView.register(GoodsTableViewCell.self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutSubviews()
    }
    
    private func layoutSubviews() {
        basketInfoHolderView.pin.height(250.0).topLeft().horizontally()
        tableView.pin.below(of: basketInfoHolderView).horizontally().bottom()
    }
}

// MARK: - Table view delegate & datasourse
extension BasketViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(GoodsTableViewCell.self, for: indexPath)
        return cell
    }
    
}

class BasketViewModel {
    
}
