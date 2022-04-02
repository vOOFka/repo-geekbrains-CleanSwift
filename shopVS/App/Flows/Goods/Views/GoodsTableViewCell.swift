//
//  GoodsTableViewCell.swift
//  shopVS
//
//  Created by Home on 02.04.2022.
//

import UIKit

final class GoodsTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.numberOfLines = 1
        priceLabel.numberOfLines = 1
        descriptionLabel.numberOfLines = 5
    }
    
    override func prepareForReuse() {
        nameLabel.text = String()
        priceLabel.text = String()
        descriptionLabel.text = String()
    }
    
    // MARK: - Config
    
    func config(for viewModel: GoodsViewCellModel) {
        self.nameLabel.text = viewModel.name
        self.priceLabel.text = String(viewModel.price)
        self.descriptionLabel.text = viewModel.description
    }    
}
