//
//  FeedbackTableViewCell.swift
//  shopVS
//
//  Created by Home on 03.04.2022.
//

import UIKit
import PinLayout

final class FeedbackTableViewCell: UITableViewCell {
    // MARK: - Public properties
    public static let reuseIdentifier = "FaqQuestionCell"
    
    // MARK: - Private properties
    private var viewModel: FeedbackViewCellModel?
    private let userImageView = UIImageView()
    private let nameLabel = UILabel()
    private let commentLabel = UILabel()
    
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
        nameLabel.numberOfLines = 1
        commentLabel.numberOfLines = 0
        contentView.addSubview(userImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(commentLabel)
        layoutSubviews()
    }
    
    override func prepareForReuse() {
        self.nameLabel.text = String()
        self.commentLabel.text = String()
    }
    
    public func config(with feedbackViewCellModel: FeedbackViewCellModel) {
        self.viewModel = feedbackViewCellModel
        
        guard let viewModel = viewModel else {
            Logger.shared.logError("viewModel is nil")
            return
        }
        
        self.nameLabel.text = "User: " + viewModel.name
        self.commentLabel.text = viewModel.comment
        self.userImageView.image = UIImage(systemName: "person.wave.2")
    }
    
    override func layoutSubviews() {
        userImageView.pin.topLeft().height(36.0).width(36.0).marginHorizontal(12.0).marginTop(12.0)
        nameLabel.pin.after(of: userImageView, aligned: .center).marginHorizontal(12.0).sizeToFit()
        commentLabel.pin.below(of: userImageView, aligned: .left).marginTop(16.0).marginHorizontal(12.0).sizeToFit()
        
        contentView.pin.height(commentLabel.frame.maxY)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        layoutSubviews()
        return CGSize(width: size.width, height: commentLabel.frame.maxY + 12.0)
    }
}
