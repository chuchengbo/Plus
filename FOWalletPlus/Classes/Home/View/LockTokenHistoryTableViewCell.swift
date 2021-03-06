//
//  LockTokenHistoryTableViewCell.swift
//  FOWalletPlus
//
//  Created by Sleep on 2018/11/30.
//  Copyright © 2018 Sleep. All rights reserved.
//

import UIKit

class LockTokenHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var typeImage: UIImageView!
    
    @IBOutlet weak var nameLabel: CopyButton!
    
    @IBOutlet weak var cretedAtLabel: UILabel!
    
    @IBOutlet weak var quantityLabel: UILabel!
    
    open var model: LockTokenHistoryModel! {
        didSet {
            if model.isReceive {
                typeImage.image = UIImage(named: "right")
                nameLabel.setTitle(model.from_account, for: .normal)
                quantityLabel.text = "+ \(model.nextQuantity)"
            } else {
                typeImage.image = UIImage(named: "left")
                nameLabel.setTitle(model.to_account, for: .normal)
                quantityLabel.text = "- \(model.nextQuantity)"
            }
            cretedAtLabel.text = model.utcCreated
        }
    }
    
    open var historyModel: TransactionHistoryModel! {
        didSet {
            if historyModel.isReceive {
                typeImage.image = UIImage(named: "right")
                nameLabel.setTitle(historyModel.from_account, for: .normal)
                quantityLabel.text = "+ \(historyModel.nextQuantity)"
            } else {
                typeImage.image = UIImage(named: "left")
                nameLabel.setTitle(historyModel.to_account, for: .normal)
                quantityLabel.text = "- \(historyModel.nextQuantity)"
            }
            cretedAtLabel.text = historyModel.utcCreated
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
