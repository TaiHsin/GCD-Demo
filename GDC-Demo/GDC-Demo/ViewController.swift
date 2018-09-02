//
//  ViewController.swift
//  GDC-Demo
//
//  Created by TaiHsinLee on 2018/8/31.
//  Copyright © 2018年 TaiHsinLee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var headView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var headLabel: UILabel!
    
    var nameData = ""
    var addressData = ""
    var headData = ""
    var dataAPIClient = DataAPIClient()
    let dispatchGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideView()
        
        dispatchGroup.enter()
        dataAPIClient.getData(apiUrl: .name) { (data, error) in
            
            guard let data = data else { return }
            print(data)
            self.nameLabel.text = data
            self.dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        dataAPIClient.getData(apiUrl: .address) { (data, error) in
            
            guard let data = data else { return }
            print(data)
            self.addressLabel.text = data
            self.dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        dataAPIClient.getData(apiUrl: .head) { (data, error) in
            
            guard let data = data else { return }
            print(data)
            self.headLabel.text = data
            self.dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.showView()
        }
    }
    
    func hideView() {
        nameView.isHidden = true
        addressView.isHidden = true
        headView.isHidden = true
    }
    
    func showView() {
        nameView.isHidden = false
        addressView.isHidden = false
        headView.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

