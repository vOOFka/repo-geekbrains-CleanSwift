//
//  BasketGoodsTableViewCell.swift
//  shopVS
//
//  Created by Home on 07.04.2022.
//

import UIKit
import PinLayout

final class BasketGoodsTableViewCell: UITableViewCell {
    // MARK: - Public properties
    public static let reuseIdentifier = "BasketGoodsTableViewCell"
    
    // MARK: - Private properties
    private var viewModel: GoodsViewCellModel?
    private var nameLabel = UILabel()
    private var priceLabel = UILabel()
    private var countLabel = UILabel()
    
    // MARK: - Init & Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialConfig()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialConfig()
    }
    
    private func initialConfig() {
        contentView.backgroundColor = .orange
        nameLabel.numberOfLines = 1
        priceLabel.numberOfLines = 1
        countLabel.numberOfLines = 1
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(countLabel)
        
        layoutSubviews()
    }
    
    override func prepareForReuse() {
        viewModel = nil
        nameLabel.text = String()
        priceLabel.text = String()
        countLabel.text = String()
    }
    
    public func config(with viewModel: GoodsViewCellModel) {
        self.viewModel = viewModel
        
        nameLabel.text = viewModel.product.name
        priceLabel.text = String(viewModel.product.price)
        countLabel.text = "\(viewModel.countInMyCard) x"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.pin.centerLeft().margin(20.0).sizeToFit()
        priceLabel.pin.centerRight().margin(20.0).sizeToFit()
        countLabel.pin.before(of: priceLabel, aligned: .center).margin(5.0).sizeToFit()
        
        contentView.pin.height(nameLabel.frame.maxY + 12.0)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        layoutSubviews()
        return CGSize(width: size.width, height: nameLabel.frame.maxY + 12.0)
    }
}
