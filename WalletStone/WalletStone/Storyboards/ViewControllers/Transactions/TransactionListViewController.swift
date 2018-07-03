//
//  TransactionListViewController.swift
//  WalletStone
//
//  Created by Andre on 13/06/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit

class TransactionListViewController: WSBaseViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var transactions: [Transaction] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fillTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension TransactionListViewController {
    
    func fillTableView() {
        tableView.register(TransactionTableViewCell.self)
        tableView.reloadData()
    }
    
}

extension TransactionListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as TransactionTableViewCell
        cell.transaction = transactions[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
    
}
