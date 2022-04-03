//
//  FeedbackTableViewCell.swift
//  shopVS
//
//  Created by Home on 03.04.2022.
//

import UIKit
import PinLayout

final class FeedbackTableViewCell: UITableViewCell {
    public static let reuseIdentifier = "FaqQuestionCell"
    private var viewModel: FeedbackViewCellModel?
    private let userImageView = UIImageView()
    private let nameLabel = UILabel()
    private let commentLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialConfig()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialConfig()
    }
    
    private func initialConfig() {
        nameLabel.numberOfLines = 0
        commentLabel.numberOfLines = 0
        addSubview(userImageView)
        addSubview(nameLabel)
        addSubview(commentLabel)
        layoutSubviews()
    }
    
    override func prepareForReuse() {
        self.nameLabel.text = String()
        self.commentLabel.text = String()
    }
    
    public func config(with feedbackViewCellModel: FeedbackViewCellModel) {
        self.viewModel = feedbackViewCellModel
        
        self.nameLabel.text = viewModel?.name
        self.commentLabel.text = viewModel?.comment
        self.userImageView.image = UIImage(systemName: "person.wave.2")
    }
    
    override func layoutSubviews() {
        contentView.pin.all()
        userImageView.pin.centerLeft().height(24.0).width(24.0)
        nameLabel.pin.after(of: userImageView, aligned: .center).marginLeft(12.0).sizeToFit()
        commentLabel.pin.below(of: userImageView, aligned: .left).sizeToFit()
        
        contentView.pin.height(commentLabel.frame.maxY + 12.0)
    }
}
