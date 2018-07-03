//
//  WSBaseViewController.swift
//  WalletStone
//
//  Created by Andre on 11/06/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit

class WSBaseViewController: UIViewController {
    
    var fenceView: WSFenceView = WSFenceView.fromNib()

    override func viewDidLoad() {
        super.viewDidLoad()
        verifyFenceView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

//MARK: - Fence Functions -
extension WSBaseViewController {
    
    private func initialSetup() {
        verifyFenceView()
    }
    
    private func verifyFenceView() {
        if(!self.fenceView.isDescendant(of: view)) {
            self.view.addSubview(self.fenceView)
            self.fenceView.bindFrameToSuperviewBounds()
            self.fenceView.isHidden = true
        }
    }
    
    func showErrorView(message: String, target: Any, action:Selector) {
        fenceView.showErrorView(message: message, target: target, action: action)
        self.view.bringSubview(toFront: fenceView)
        self.fenceView.isHidden = false
    }
    
    @objc public func showLoadingView() {
        fenceView.showFenceLoadingView()
        view.bringSubview(toFront: fenceView)
        fenceView.isHidden = false
    }
    
    func hideFenceView() {
        view.sendSubview(toBack: fenceView)
        fenceView.isHidden = true
    }
    
    func showWSAlert(with message: String) {
        let alert = UIAlertController(title: "Atenção", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.view.tintColor = .darkGreen
        present(alert, animated: true)
    }
    
}

//MARK: - Close Modal -
extension WSBaseViewController {
    
    func showCloseModal() {
        let imageIcon = UIImage(named: "ic_close")
        
        let backButton:UIBarButtonItem = UIBarButtonItem(image: imageIcon,
                                                              style: .plain,
                                                              target: target,
                                                              action: #selector(closeModal))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.hidesBackButton = false
    }
    
    @objc private func closeModal() {
        dismiss(animated: true, completion: nil)
    }
    
}
