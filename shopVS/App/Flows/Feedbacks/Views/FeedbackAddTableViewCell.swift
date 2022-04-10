//
//  FeedbackAddTableViewCell.swift
//  shopVS
//
//  Created by Home on 03.04.2022.
//

import UIKit
import PinLayout

protocol AddFeedbackButtonDelegate: AnyObject {
    func addFeedbackButtonTap(newFeedback: Feedback)
}

final class FeedbackAddTableViewCell: UITableViewCell {
    // MARK: - Public properties
    public static let reuseIdentifier = "FeedbackAddTableViewCell"
    weak var delegate: AddFeedbackButtonDelegate?
    
    // MARK: - Private properties
    private let addFeedbackButton = UIButton()
    private let commentTextView = UITextView()
    
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
        addFeedbackButton.backgroundColor = .orange
        addFeedbackButton.layer.cornerRadius = 3.0
        addFeedbackButton.clipsToBounds = true
        addFeedbackButton.setTitle("Add feedback", for: .normal)
        addFeedbackButton.addTarget(self, action: #selector(addFeedbackButtonTap), for: .touchUpInside)
        
        commentTextView.backgroundColor = .lightGray
        commentTextView.text = "This product is ..."
        commentTextView.isScrollEnabled = false
        
        contentView.addSubview(addFeedbackButton)
        contentView.addSubview(commentTextView)
        layoutSubviews()
    }
    
    override func layoutSubviews() {
        contentView.pin.all()
        addFeedbackButton.pin.height(44.0).width(120.0).top(12.0).hCenter()
        commentTextView.pin.below(of: addFeedbackButton).horizontally(12.0).height(120.0).marginTop(12.0)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        layoutSubviews()
        return CGSize(width: size.width, height: commentTextView.frame.maxY + 12.0)
    }
    
    //MARK: - Actions
    @objc func addFeedbackButtonTap(sender: UIButton!) {
        guard let currentUser = AppSession.shared.currentUser,
              let comment = commentTextView.text
        else {
            Logger.shared.logError("viewModel is nil", param: ["file" : #file, "func" : #function])
            return
        }
        Logger.shared.logEvent("addFeedbackButtonTap")
        let newFeedback = Feedback(id: 0, userId: currentUser.id, comment: comment)
        delegate?.addFeedbackButtonTap(newFeedback: newFeedback)
    }
}

