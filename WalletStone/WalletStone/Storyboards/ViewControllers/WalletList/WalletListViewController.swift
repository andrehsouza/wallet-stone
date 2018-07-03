//
//  WalletListViewController.swift
//  WalletStone
//
//  Created by Andre on 12/06/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit

class WalletListViewController: WSBaseViewController {
    
    @IBOutlet var tableView: UITableView!

    var wallets:[Wallet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshWallets()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToList(segue: UIStoryboardSegue) {
        refreshWallets()
    }
    
}

extension WalletListViewController {
    
    func refreshWallets() {
        if let wallets = WSUtil.shared.customer?.wallets {
            self.wallets = wallets.sorted(by: { $0.cryptoCurrency.name < $1.cryptoCurrency.name })
        }
        fillTableView()
    }
    
    func fillTableView() {
        tableView.register(WalletTableViewCell.self)
        tableView.reloadData()
    }
    
}

extension WalletListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wallets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as WalletTableViewCell
        cell.wallet = wallets[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(type: .wallet)
        let viewController = storyboard.instantiateViewController() as WalletDetailViewController
        viewController.wallet = wallets[indexPath.row]
        show(viewController, sender: self)
    }
    
}
