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
        basketViewModel = BasketViewModel()
        configUI()
        updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateUI()
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
        
        cleanBasketButton.setTitle("Cleaning", for: .normal)
        cleanBasketButton.addTarget(self, action: #selector(cleanBasketButtonTap), for: .touchUpInside)
        cleanBasketButton.setTitleColor(UIColor.lightGray, for: .normal)
        cleanBasketButton.setTitleColor(UIColor.gray, for: .highlighted)
        cleanBasketButton.layer.borderColor = UIColor.gray.cgColor
        cleanBasketButton.layer.borderWidth = 1.0
        cleanBasketButton.layer.cornerRadius = 6.0
        cleanBasketButton.clipsToBounds = true
        cleanBasketButton.isEnabled = false
        
        payBasketButton.setTitle("Order payment", for: .normal)
        payBasketButton.addTarget(self, action: #selector(payBasketButtonTap), for: .touchUpInside)
        payBasketButton.backgroundColor = .orange
        payBasketButton.setTitleColor(UIColor.black, for: .normal)
        payBasketButton.setTitleColor(UIColor.gray, for: .highlighted)
        payBasketButton.layer.cornerRadius = 6.0
        payBasketButton.clipsToBounds = true
        payBasketButton.isEnabled = false
        
        separatorView.backgroundColor = .lightGray
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.separatorColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        tableView.registerClass(BasketGoodsTableViewCell.self)
    }
    
    func updateUI() {
        guard let basketViewModel = basketViewModel else {
            return
        }
        basketViewModel.updateBasket {
            self.goodsCountLabel.text = "Goods count: \(basketViewModel.goodsCount)"
            self.totalSummaLabel.text = "Total summa: \(basketViewModel.totalSumma)"
            self.payBasketButton.isEnabled = basketViewModel.cellsArray.count > 0 ? true : false
            self.cleanBasketButton.isEnabled = payBasketButton.isEnabled
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutSubviews()
    }
    
    private func layoutSubviews() {
        basketInfoHolderView.pin.height(250.0).topLeft().horizontally()
        titleLabel.pin.topCenter(30.0).sizeToFit()
        goodsCountLabel.pin.below(of: titleLabel).minWidth(200.0).hCenter().margin(24.0).sizeToFit()
        totalSummaLabel.pin.below(of: goodsCountLabel).minWidth(200.0).hCenter().margin(24.0).sizeToFit()
        cleanBasketButton.pin.minWidth(120.0).margin(24.0).bottomLeft().sizeToFit()
        payBasketButton.pin.minWidth(160.0).margin(24.0).bottomRight().sizeToFit()
        
        separatorView.pin.below(of: basketInfoHolderView).height(1.0).horizontally()
        tableView.pin.below(of: separatorView).horizontally().bottom()
    }
    
    //MARK: - Actions
    @objc func cleanBasketButtonTap() {
        basketViewModel?.cleanBasket(completion: {
            self.updateUI()
        })
    }
    
    @objc func payBasketButtonTap() {
        basketViewModel?.payBasketRequest { result in
            switch result {
            case .Success(_):
                self.updateUI()
                self.showError(message: "Thanks for the order", title: "Successful payment", handler: nil)
            case .Failure(let error):
                self.showError(message: error, title: "Error", handler: nil)
            }
        }
    }
}

// MARK: - Table view delegate & datasourse
extension BasketViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        basketViewModel?.cellsArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(BasketGoodsTableViewCell.self, for: indexPath)
        guard let cellsViewModels = basketViewModel?.cellsArray else {
            return cell
        }
        cell.config(with: cellsViewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
