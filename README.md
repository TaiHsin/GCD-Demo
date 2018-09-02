# GCD-Demo
Grand Central Dispatch (GCD) group and semaphore practice

## Dispatch.Group

In the branch I use dispatch group to wait all three API data finish and display view at the same time.

First create instance of dispatch group.
At the mean tiem we also decalare 

```
let dispatchGroup = DispatchGroup()
```

In the three getData() method that called in viewDidLoad(), we use `enter()` and `leave()` method for group to increment and decrement group task's count.

```
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
```

In `getData()` we store each data to each property that we decalare at the first (name, address, and head).


When all the group task have already finish (which mean the group task count reaches zero) and got data, the notify method with closure will be called. 

	
	dispatchGroup.notify(queue: .main) {
	    self.nameLabel.text = self.nameData
	    self.addressLabel.text = self.addressData
	    self.headLabel.text = self.headData
	    self.showView()
	}

In notify closure we store each property data to each label and show the view to display on screen at the same time.

Reference: 	
https://www.youtube.com/watch?v=lOI0aUkeuLw
https://www.swiftbysundell.com/posts/a-deep-dive-into-grand-central-dispatch-in-swift	
https://juejin.im/post/5acaea17f265da239a601a01
