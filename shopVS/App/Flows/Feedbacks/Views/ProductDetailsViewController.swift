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
            feedbacksViewModel?.update(pageNumber: pageNumber, productId: productViewModel?.product.id ?? 0) { [weak self] in
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
        tableView.registerClass(FeedbackAddTableViewCell.self)
        
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

// MARK: - Table view delegate & datasourse
extension ProductDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int { 2 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return getCountFeedbackCells() + 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let cell = tableView.dequeueReusableCell(GoodsTableViewCell.self, for: indexPath)
        let feedbackAddCell = tableView.dequeueReusableCell(FeedbackAddTableViewCell.self, for: indexPath)
        let feedbackCell = tableView.dequeueReusableCell(FeedbackTableViewCell.self, for: indexPath)
        
        guard let productViewModel = productViewModel else {
            Logger.shared.logError("viewModel is nil")
            return cell
        }
        
        switch section {
        case 0:
            cell.config(for: productViewModel)
            return cell
        case 1:
            guard let cellsArray = feedbacksViewModel?.cellsArray?.compactMap(FeedbackViewCellModel.self) else {
                Logger.shared.logError("viewModels is nil")
                return feedbackCell
            }
            if indexPath.row == 0 {
                feedbackAddCell.delegate = self
                return feedbackAddCell
            } else {
                let index = indexPath.row - 1
                feedbackCell.config(with: cellsArray[index])
                return feedbackCell
            }
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextDeleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _,_,_ in
            guard let productId = self?.productViewModel?.product.id,
                  let feedbacks = self?.feedbacksViewModel?.cellsArray?.compactMap(FeedbackViewCellModel.self)
            else {
                Logger.shared.logError("viewModel is nil")
                return
            }
            let feedbackId = feedbacks[(indexPath.row - 1)].id
            self?.feedbacksViewModel?.removeFeedbackRequest(productId: productId, feedbackId: feedbackId) {
                self?.tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
            }
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextDeleteAction])
        return swipeActions
    }
}

//MARK: - Actions, AddFeedbackButtonDelegate
extension ProductDetailsViewController: AddFeedbackButtonDelegate {
    func addFeedbackButtonTap(newFeedback: Feedback) {
        guard let productId = productViewModel?.product.id else {
            Logger.shared.logError("viewModel is nil")
            return
        }
        feedbacksViewModel?.addFeedbackRequest(productId: productId, newFeedback: newFeedback) { [weak self] in
            self?.tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
        }
    }
}
