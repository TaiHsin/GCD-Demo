# GCD-Demo
Grand Central Dispatch (GCD) group and semaphore practice

## Dispatch.Semaphore

In the branch I use dispatch semaphore to get and display data in order with delay one second.

To use semaphore, we need to create it's instance first. Here we create instance with argument value is 1. The **value** parameter is the number of threads that can access to the resource as for the semaphore creation.

```
let semaphore = DispatchSemaphore(value: 1)
```


In order to display view and data clearly, we add `run()` method to delay the data requestment and data display. The method declared below:

    func run(after seconds: Int, completion: @escaping () -> Void) {
        let deadline = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            completion()
        }
    }

* Some important defination of semaphore from web [A Quick Look at Semaphores in Swift](https://medium.com/swiftly-swift/a-quick-look-at-semaphores-6b7b85233ddb): 

>**The Semaphore is composed by:**   
*A counter that let the Semaphore know how many threads can use its resource(s).   
A FIFO queue for tracking the threads waiting for the resource.*  
**Resource Request: `wait()`** 	  
*When the semaphore receives a request, it checks if its counter is above zero:	 
if yes, then the semaphore decrements it and gives the thread the green light. Otherwise it pushes the thread at the end of its queue*	
**Resource Release: `signal()`** 	
*Once the semaphore receives a signal, it checks if its FIFO queue has threads in it 	
if yes, then the semaphore pulls the first thread and give him the green light. otherwise it increments its counter*



In the three getData() method that called in viewDidLoad(), we use `wait()` to request the semaphore’s resource and also use `signal()` to release the resource.


Here we called `run()` method in getData closure with one second delay to make UI display more clear.


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
    
> *Note: `semaphore.wait()` is called before getData method and `semaphore.signal()` is used after last line in getData's closure.*
> *Due to semaphore is operate at the background, we need to set all three method to `Dispatch.global().async{ }`*


In `getData()`, after get data the data will store to label.text and it's view will display to screen with one second delay.

---

* Reference:      
[A Quick Look at Semaphores in Swift](https://medium.com/swiftly-swift/a-quick-look-at-semaphores-6b7b85233ddb)   
[iOS Swift GCD 開發教程](https://juejin.im/post/5acaea17f265da239a601a01)    
[A deep dive into Grand Central Dispatch in Swift](https://www.swiftbysundell.com/posts/a-deep-dive-into-grand-central-dispatch-in-swift)

