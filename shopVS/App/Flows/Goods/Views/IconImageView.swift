//
//  IconImageView.swift
//  shopVS
//
//  Created by Home on 03.04.2022.
//

import UIKit

@IBDesignable
class IconImageView: UIImageView {

    @IBInspectable var cornerRadius : CGFloat = 0.0 {
        didSet{
            self.applyCornerRadius()
        }
    }

    @IBInspectable var borderColor : UIColor = UIColor.clear {
        didSet{
            self.applyCornerRadius()
        }
    }

    @IBInspectable var borderWidth : Double = 0 {
        didSet{
            self.applyCornerRadius()
        }
    }

    @IBInspectable var circular : Bool = false {
        didSet{
            self.applyCornerRadius()
        }
    }

    func applyCornerRadius()
    {
        if(self.circular) {
            self.layer.cornerRadius = self.bounds.size.height/2
            self.layer.masksToBounds = true
            self.layer.borderColor = self.borderColor.cgColor
            self.layer.borderWidth = CGFloat(self.borderWidth)
        }else {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
            self.layer.borderColor = self.borderColor.cgColor
            self.layer.borderWidth = CGFloat(self.borderWidth)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.applyCornerRadius()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        applyCornerRadius()
    }
}
