//
//  TransactionTableViewCell.swift
//  WalletStone
//
//  Created by Andre on 13/06/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell, NibLoadableView {
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var symbolLbl: UILabel!
    @IBOutlet weak var valueLbl: UILabel!
    
    var transaction: Transaction? {
        didSet {
            dateLbl.text = transaction?.date.stringFormat()
            symbolLbl.text = transaction?.transactionType.symbol
            valueLbl.text = transaction?.value
            valueLbl.textColor = transaction?.transactionType.color
            symbolLbl.textColor = transaction?.transactionType.color
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
