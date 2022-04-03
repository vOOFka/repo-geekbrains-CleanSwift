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
    var feedbacksViewModel: FeedbacksViewModel?
    {
        didSet {
            feedbacksViewModel?.update(pageNumber: pageNumber, productId: productViewModel?.id ?? 0) { [weak self] in
                self?.tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
            }
        }
    }
    
    // MARK: - Private properties
    private var tableView = UITableView()
    private let appService = AppService()
    private let pageNumber = 99999999

     
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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        tableView.register(GoodsTableViewCell.self)
        tableView.registerClass(FeedbackTableViewCell.self)
        
        feedbacksViewModel = FeedbacksViewModel()
        layoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutSubviews()
    }
    
    private func layoutSubviews() {
        tableView.pin.all()
    }
    
    private func getCountFeedbackCells() -> Int {
        guard let cellsArray = feedbacksViewModel?.cellsArray else {
            return 0
        }
        
        switch cellsArray {
        case .Success(let cellsArray):
            return cellsArray.count
        case .Failure(_):
            return 0
        }
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
            return getCountFeedbackCells()
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let cell = tableView.dequeueReusableCell(GoodsTableViewCell.self, for: indexPath)
        let feedbackCell = tableView.dequeueReusableCell(FeedbackTableViewCell.self, for: indexPath)
        
        guard let productViewModel = productViewModel else {
            return cell
        }
        
        switch section {
        case 0:
            cell.config(for: productViewModel)
            return cell
        case 1:
            guard let cellsArray = feedbacksViewModel?.cellsArray?.compactMap(FeedbackViewCellModel.self) else {
                return feedbackCell
            }
            feedbackCell.config(with: cellsArray[indexPath.row])
            return feedbackCell
        default:
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
