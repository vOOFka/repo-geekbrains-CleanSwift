//
//  GoodsTableViewController.swift
//  shopVS
//
//  Created by Home on 28.03.2022.
//

import UIKit

class GoodsTableViewController: UITableViewController {    
    var viewModel: GoodsViewModel? {
        didSet {
            viewModel?.update(pageNumber: -1, categoryId: 123) { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.cellsArray.count ?? 0
    }
}


final class GoodsViewModel {
    private let requestFactory = RequestFactory()
    private(set) var cellsArray: [GoodsViewCellModel] = []
    
    func update(pageNumber: Int, categoryId: Int, completion: @escaping () -> Void) {
        let goods = requestFactory.makeGoodsRequestFactory()
        
        goods.getCatalogData(pageNumber: pageNumber, categoryId: categoryId) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let catalogResult):
                DispatchQueue.main.async {
                    if catalogResult.result == 1,
                       let goods = catalogResult.goods {
                       //TODO
                        completion()
                    } else {
                        //TODO
                        //self.showError(message: catalogResult.errorMessage ?? "Unknow error, please try again later.")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    //TODO
                    //self.showError(message: error.localizedDescription)
                }
            }
        }
    }
    

}


final class GoodsViewCellModel {
    
}

