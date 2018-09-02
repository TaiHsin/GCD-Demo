# GCD-Demo
Grand Central Dispatch (GCD) group and semaphore practice

## Dispatch.Group

In the branch I use dispatch group to wait all three API data finish and display view at the same time.

First create instance of dispatch group.

```
let dispatchGroup = DispatchGroup()
```

In the three getData method that called in viewDidLoad(), we use `enter()` and `leave()` for group to increment and decrement group task's count.

```
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
```
>   *Note: There are two ways to add task into groups. First one is add group with async argument `group:`. Second one is to use group enter and leave method to let group know how many tasks right now in group.*



When all the group task have already finish (which mean the group task count reaches zero) and got data, the notify method with closure will be called. 

	
	dispatchGroup.notify(queue: .main) {
	    self.showView()
	}

In notify closure we simply just show all three view on screen.

---

* Reference: 	   
[(Youtube) DispatchGroup: Waiting for Data | Swift 4, Xcode 9](https://www.youtube.com/watch?v=lOI0aUkeuLw)     
[A deep dive into Grand Central Dispatch in Swift](https://www.swiftbysundell.com/posts/a-deep-dive-into-grand-central-dispatch-in-swift)	
[iOS Swift GCD 開發教程](https://juejin.im/post/5acaea17f265da239a601a01)
