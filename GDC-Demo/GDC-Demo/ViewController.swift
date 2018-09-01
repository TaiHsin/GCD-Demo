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
    
    var dataAPIClient = DataAPIClient()
    let group = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataAPIClient.getData(apiUrl: .name) { (data, error) in
            self.group.enter()
            
            guard let dataName = data else { return }
            self.nameLabel.text = dataName
            
            self.group.wait()
        }
        
        dataAPIClient.getData(apiUrl: .address) { (data, error) in
            self.group.enter()
            
            guard let dataAddress = data else { return }
            self.addressLabel.text = dataAddress
            self.group.wait()
        }
        
        dataAPIClient.getData(apiUrl: .head) { (data, error) in
            
            self.group.enter()
            guard let dataHead = data else { return }
            self.headLabel.text = dataHead
            self.group.wait()
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

