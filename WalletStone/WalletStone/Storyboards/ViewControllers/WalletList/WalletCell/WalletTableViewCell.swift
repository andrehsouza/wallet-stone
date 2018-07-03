//
//  WalletTableViewCell.swift
//  WalletStone
//
//  Created by Andre on 12/06/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit

class WalletTableViewCell: UITableViewCell, NibLoadableView {
    
    @IBOutlet weak var walletNameLbl: UILabel!
    @IBOutlet weak var symbolLbl: UILabel!
    @IBOutlet weak var valueLbl: UILabel!
    
    var wallet: Wallet? {
        didSet {
            walletNameLbl.text = wallet?.cryptoCurrency.name
            symbolLbl.text = wallet?.cryptoCurrency.symbol
            valueLbl.text = wallet?.balanceValue.decimalFormat()
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
