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
        
        dispatchGroup.enter()
        dataAPIClient.getData(apiUrl: .name) { (data, error) in
            
            guard let data = data else { return }
            print(data)
            self.nameData = data
            self.dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        dataAPIClient.getData(apiUrl: .address) { (data, error) in
            
            guard let data = data else { return }
            print(data)
            self.addressData = data
            self.dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        dataAPIClient.getData(apiUrl: .head) { (data, error) in
            
            guard let data = data else { return }
            print(data)
            self.headData = data
            self.dispatchGroup.leave()
        }
        
        dispatchGroup.wait()
        print("update")
        update()
//        dispatchGroup.notify(queue: .main) {
//            self.nameLabel.text = self.nameData
//            self.addressLabel.text = self.addressData
//            self.headLabel.text = self.headData
//        }
    }
    func update() {
        self.nameLabel.text = self.nameData
        self.addressLabel.text = self.addressData
        self.headLabel.text = self.headData
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

