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
    let semaphore = DispatchSemaphore(value: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideView()
        
        DispatchQueue.global().async {
            self.semaphore.wait()
            self.dataAPIClient.getData(apiUrl: .name) { (data, error) in
                self.run(after: 1, completion: {
                    guard let data = data else { return }
                    print(data)
                    self.nameLabel.text = data
                    self.nameView.isHidden = false
                    self.semaphore.signal()
                })
            }
            
            self.semaphore.wait()
            self.dataAPIClient.getData(apiUrl: .address) { (data, error) in
                self.run(after: 1, completion: {
                    guard let data = data else { return }
                    print(data)
                    self.addressLabel.text = data
                    self.addressView.isHidden = false
                    self.semaphore.signal()
                })
            }
            
            self.semaphore.wait()
            self.dataAPIClient.getData(apiUrl: .head) { (data, error) in
                self.run(after: 1, completion: {
                    guard let data = data else { return }
                    print(data)
                    self.headLabel.text = data
                    self.headView.isHidden = false
                    self.semaphore.signal()
                })
            }
        }
    }
    
    func run(after seconds: Int, completion: @escaping () -> Void) {
        let deadline = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            completion()
        }
    }
    
    func hideView() {
        nameView.isHidden = true
        addressView.isHidden = true
        headView.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

