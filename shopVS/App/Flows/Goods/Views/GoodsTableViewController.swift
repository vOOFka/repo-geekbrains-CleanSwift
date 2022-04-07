//
//  GoodsTableViewController.swift
//  shopVS
//
//  Created by Home on 28.03.2022.
//

import UIKit

class GoodsTableViewController: UITableViewController {
    // MARK: - Public properties
    var viewModel: GoodsViewModel?
    {
        didSet {
            viewModel?.update(pageNumber: pageNumber, categoryId: categoryId) { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Private properties
    private var pageNumber = 9999999
    private var categoryId = 321    
    private let appService = AppService()
     
    // MARK: - Init & Lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(GoodsTableViewCell.self)
        tableView.showsVerticalScrollIndicator = false        
        viewModel = GoodsViewModel()
    }    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateUI()
    }
    
    func updateUI() {
        guard let viewModel = viewModel else {
            return
        }
        viewModel.updateCellsArrayByMyCard {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cells = viewModel?.cellsArray else {
            return 0
        }
        switch cells {
        case .Success(let cellsArray):
            return cellsArray.count
        case .Failure(let error):
            self.showError(message: error, title: "Error", handler: nil)
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(GoodsTableViewCell.self, for: indexPath)
        guard let cellsViewModels = viewModel?.cellsArray else {
            return cell
        }
        switch cellsViewModels {
        case .Success(let cellsViewModels):
            cell.config(for: cellsViewModels[indexPath.row])
        case .Failure(_):
            break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cellsViewModels = viewModel?.cellsArray else {
            return
        }
        switch cellsViewModels {
        case .Success(let cellsViewModels):
            let productViewModel = cellsViewModels[indexPath.row]
            let productDetailsViewController = ProductDetailsViewController(productViewModel: productViewModel)
            self.navigationController?.pushViewController(productDetailsViewController, animated: true)
        case .Failure(_):
            break
        }
    }
    
    //MARK: - Actions
    @IBAction func profileButtonTap(_ sender: UIBarButtonItem) {
        appService.showModalScene(viewController: self, with: .userProfile)
    }
    
    @IBAction func refreshButtonTap(_ sender: UIBarButtonItem) {
        viewModel?.update(pageNumber: pageNumber, categoryId: categoryId) { [weak self] in
            self?.tableView.reloadData()
        }
    }
    @IBAction func exitButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}
