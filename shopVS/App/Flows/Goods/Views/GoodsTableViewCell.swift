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
    @IBOutlet weak var iconImageView: IconImageView!
    @IBOutlet weak var countInMyCardLabel: UILabel!
    @IBOutlet weak var basketStepper: UIStepper!
    
    // MARK: - Private properties
    private var viewModel: GoodsViewCellModel?
    private var countInMyCard: Int = 0
    
    // MARK: - Init & Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.numberOfLines = 1
        priceLabel.numberOfLines = 1
        descriptionLabel.numberOfLines = 3
    }
    
    override func prepareForReuse() {
        viewModel = nil
        countInMyCard = 0
        basketStepper.value = 0.0
        nameLabel.text = String()
        priceLabel.text = String()
        descriptionLabel.text = String()
        countInMyCardLabel.text = String()
    }
    
    // MARK: - Config
    func config(for viewModel: GoodsViewCellModel) {
        self.viewModel = viewModel
        self.nameLabel.text = viewModel.product.name
        self.priceLabel.text = String(viewModel.product.price)
        self.descriptionLabel.text = viewModel.product.description
        self.countInMyCard = viewModel.countInMyCard
        self.countInMyCardLabel.text = String(countInMyCard)
        self.basketStepper.value = Double(countInMyCard)
    }
    
    // MARK: - Actions
    @IBAction func changeGoodsInMyCard(_ sender: UIStepper) {
        let value = Int(sender.value)
        guard let viewModel = viewModel,
              0...10 ~= value
        else {
            Logger.shared.logError("viewModel is nil", param: ["file" : #file, "func" : #function])
            return
        }        
        
        if value > countInMyCard {
            UserBasket.shared.addProduct(viewModel.product)
            countInMyCard += 1
            countInMyCardLabel.text = String(countInMyCard)
            Logger.shared.logEvent("Added \(viewModel.product.name) in mycard \(countInMyCard)")
        } else {
            UserBasket.shared.removeProduct(viewModel.product)
            countInMyCard -= 1
            countInMyCardLabel.text = String(countInMyCard)
            Logger.shared.logEvent("Remove \(viewModel.product.name) from mycard \(countInMyCard)")
        }
    }
}
