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
                
                guard let data = data else { return }
                self.nameLabel.text = data
                
            }
            
            dataAPIClient.getData(apiUrl: .address) { (data, error) in
        
                guard let data = data else { return }
                self.addressLabel.text = data

            }
            
            dataAPIClient.getData(apiUrl: .head) { (data, error) in
                
                guard let data = data else { return }
                self.headLabel.text = data

            }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

