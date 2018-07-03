//
//  MyAccountViewController.swift
//  WalletStone
//
//  Created by Andre on 13/06/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit

class MyAccountViewController: WSBaseViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    
    fileprivate lazy var presenter: MyAccountViewPresenter = MyAccountViewPresenter(view: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = WSUtil.shared.customer?.name
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func touchExit(_ sender: Any) {
        presenter.logout()
        performSegue(withIdentifier: MyAccountViewController.identifier, sender: self)
    }

}

extension MyAccountViewController: MyAccountViewProtocol {
    
}

