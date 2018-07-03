//
//  OperationViewController.swift
//  WalletStone
//
//  Created by Andre on 13/06/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit

enum OperationType {
    case buy
    case sell
    
    var title: String {
        switch self {
        case .buy:
            return "Comprar"
        case .sell:
            return "Vender"
        }
    }
    
    var color: UIColor {
        switch self {
        case .buy:
            return UIColor(colorHex: 0x93E972)
        case .sell:
            return UIColor(colorHex: 0xE97D47)
        }
    }
    
}

class OperationViewController: WSBaseViewController {
    
    @IBOutlet weak var symbolLbl: UILabel!
    @IBOutlet weak var valueLbl: UILabel!
    @IBOutlet weak var txfValueOperation: WSTextField!
    @IBOutlet weak var txfValueReal: WSTextField!
    @IBOutlet weak var btOperation: WSButton!
    @IBOutlet weak var txtLbl: UILabel!
    
    fileprivate lazy var presenter: OperationViewPresenter = OperationViewPresenter(view: self)
    
    var operation: OperationType = .buy
    var wallet: Wallet?
    var cryptoCurrency: CurrencyModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func touchBt(_ sender: Any) {
        doOperation()
    }
    
    @IBAction func editingChanged(_ sender: Any) {
        txfValueReal.text = ""
        if let amountString = txfValueOperation.text?.currencyInputFormatting() {
            txfValueOperation.text = amountString
            convertValue()
        }
    }
    

}

extension OperationViewController {
    
    func setup() {
        title = "\(operation.title) \(wallet?.cryptoCurrency.name ?? "")"
        btOperation.fillColor = operation.color
        btOperation.setTitle(operation.title, for: .normal)
        txtLbl.text = "Valor de mercado: \(cryptoCurrency?.value?.decimalFormat() ?? "??")"
        symbolLbl.text = wallet?.cryptoCurrency.symbol
        valueLbl.text = wallet?.balanceValue.decimalFormat()
    }
    
    func convertValue() {
        
        guard
            let currencyValue = cryptoCurrency?.value,
            let valueText = txfValueOperation.text,
            let valueDouble = valueText.toDouble()
        else {
            return
        }
        
        let realValue = valueDouble * currencyValue
        txfValueReal.text = "R$ \(realValue.decimalFormat())"
    }
    
    func doOperation() {
        
        guard
            let wallet = self.wallet,
            let currencyValue = cryptoCurrency?.value,
            let valueText = txfValueOperation.text,
            let valueDouble = valueText.toDouble()
            else {
                return
        }
        
        if operation == .buy {
            presenter.buyCryptoCurrency(operationWallet: wallet,
                                        valueDouble: valueDouble,
                                        currencyValue: currencyValue)
        } else {
            presenter.sellCryptoCurrency(operationWallet: wallet,
                                         valueDouble: valueDouble,
                                         currencyValue: currencyValue)
        }
    }
    
}

extension OperationViewController: OperationViewProtocol {
    
    func showMessage(message: String) {
        showWSAlert(with: message)
    }
    
    func goToList() {
        self.performSegue(withIdentifier: OperationViewController.identifier, sender: self)
    }
    
}
