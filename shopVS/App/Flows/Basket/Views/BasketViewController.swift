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
    private var titleLabel = UILabel()
    private var goodsCountLabel = UILabel()
    private var totalSummaLabel = UILabel()
    private var payBasketButton = UIButton()
    private var cleanBasketButton = UIButton()
    private var separatorView = UIView()
    private var tableView = UITableView()
    
    // MARK: - Init & Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        basketViewModel = BasketViewModel()
    }
    
    private func configUI() {
        view.addSubview(basketInfoHolderView)
        view.addSubview(separatorView)
        view.addSubview(tableView)
        
        basketInfoHolderView.addSubview(titleLabel)
        basketInfoHolderView.addSubview(goodsCountLabel)
        basketInfoHolderView.addSubview(totalSummaLabel)
        basketInfoHolderView.addSubview(cleanBasketButton)
        basketInfoHolderView.addSubview(payBasketButton)
        
        titleLabel.text = "My cart"
        titleLabel.font = UIFont.systemFont(ofSize: 22.0)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .gray
        
        goodsCountLabel.text = "goodsCountLabel"
        totalSummaLabel.text = "totalSummaLabel"
        
        cleanBasketButton.setTitle("Cleaning", for: .normal)
        cleanBasketButton.setTitleColor(UIColor.lightGray, for: .normal)
        cleanBasketButton.layer.borderColor = UIColor.gray.cgColor
        cleanBasketButton.layer.borderWidth = 1.0
        cleanBasketButton.layer.cornerRadius = 6.0
        cleanBasketButton.clipsToBounds = true
        
        payBasketButton.setTitle("Order payment", for: .normal)
        payBasketButton.backgroundColor = .orange
        payBasketButton.setTitleColor(UIColor.black, for: .normal)
        payBasketButton.layer.cornerRadius = 6.0
        payBasketButton.clipsToBounds = true
        
        separatorView.backgroundColor = .lightGray
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        tableView.register(GoodsTableViewCell.self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutSubviews()
    }
    
    private func layoutSubviews() {
        basketInfoHolderView.pin.height(250.0).topLeft().horizontally()
        titleLabel.pin.topCenter(30.0).sizeToFit()
        goodsCountLabel.pin.below(of: titleLabel).hCenter().margin(24.0).sizeToFit()
        totalSummaLabel.pin.below(of: goodsCountLabel).hCenter().margin(24.0).sizeToFit()
        cleanBasketButton.pin.minWidth(120.0).margin(24.0).bottomLeft().sizeToFit()
        payBasketButton.pin.minWidth(160.0).margin(24.0).bottomRight().sizeToFit()
        
        separatorView.pin.below(of: basketInfoHolderView).height(1.0).horizontally()
        tableView.pin.below(of: separatorView).horizontally().bottom()
    }
}

// MARK: - Table view delegate & datasourse
extension BasketViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        basketViewModel?.cellsArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(GoodsTableViewCell.self, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
