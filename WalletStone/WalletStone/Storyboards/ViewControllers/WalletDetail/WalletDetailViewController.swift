//
//  WalletDetailViewController.swift
//  WalletStone
//
//  Created by Andre on 13/06/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit

class WalletDetailViewController: WSBaseViewController {
    
    fileprivate lazy var presenter: WalletDetailViewPresenter = WalletDetailViewPresenter(view: self)
    
    @IBOutlet weak var symbolLbl: UILabel!
    @IBOutlet weak var valueLbl: UILabel!
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var buyValueLbl: UILabel!
    @IBOutlet weak var fontLbl: UILabel!
    @IBOutlet weak var btBuy: UIButton!
    @IBOutlet weak var btSell: UIButton!
    
    var wallet: Wallet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func touchBuy(_ sender: Any) {
        goToOperation(.buy)
    }
    
    @IBAction func touchSell(_ sender: Any) {
        goToOperation(.sell)
    }

    @IBAction func touchExtract(_ sender: Any) {
        goToExtract()
    }
    
}

//MARK: - Functions -

extension WalletDetailViewController {
    
    func setup() {
        title = wallet?.cryptoCurrency.name
        symbolLbl.text = wallet?.cryptoCurrency.symbol
        valueLbl.text = wallet?.balanceValue.decimalFormat()
        fontLbl.text = ""
        buyValueLbl.text = ""
        textLbl.text = ""
        presenter.request()
    }
    
    func getCurrency(_ cryptoCurrency: Cryptocurrency) -> CurrencyModel? {
        switch cryptoCurrency {
        case .bitcoin:
            return presenter.priceModel?.currencies?[Cryptocurrency.bitcoin.symbol]
        case .brita:
            return presenter.priceModel?.currencies?[Cryptocurrency.dolar.symbol]
        default:
            return nil
        }
    }
    
    func goToExtract() {
        guard let wallet = self.wallet else { return }
        let storyBoard = UIStoryboard(type: .wallet)
        let viewController = storyBoard.instantiateViewController() as TransactionListViewController
        let transactionsArray = presenter.getTransactions(wallet)
        viewController.transactions = transactionsArray
        show(viewController, sender: self)
    }
    
    func goToOperation(_ type: OperationType) {
        
        guard
            let wallet = self.wallet
        else { return }
        
        let storyBoard = UIStoryboard(type: .wallet)
        let viewController = storyBoard.instantiateViewController() as OperationViewController
        viewController.operation = type
        viewController.wallet = wallet
        viewController.cryptoCurrency = getCurrency(wallet.cryptoCurrency)
        show(viewController, sender: self)
    }
    
    @objc func request() {
        presenter.request()
    }
    
}

//MARK: - WalletDetailViewProtocol -

extension WalletDetailViewController: WalletDetailViewProtocol {
    
    func showLoader() {
        showLoadingView()
    }
    
    func hideLoader() {
        hideFenceView()
    }
    
    func showRequestError(message: String) {
        showErrorView(message: message,
                      target: self,
                      action: #selector(self.request))
    }
    
    func fillPriceData() {
        guard let cryptoCurrency = wallet?.cryptoCurrency else { return }
        if let curency = getCurrency(cryptoCurrency), cryptoCurrency != .real  {
            textLbl.text = "Valor da compra:"
            if let dateMillis = curency.date {
                let date = Date(milliseconds: dateMillis)
                fontLbl.text = "Consulta \(date.stringFormat()) em \(curency.font ?? "UOL Economia - http://economia.uol.com.br")"
            }
            
            buyValueLbl.text = "\(curency.value?.decimalFormat() ?? "Dados indisponíveis")"
        } else {
            btBuy.isHidden = true
            btSell.isHidden = true
        }
    }
    
}
