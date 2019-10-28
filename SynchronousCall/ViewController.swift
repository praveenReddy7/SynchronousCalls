//
//  ViewController.swift
//  SynchronousCall
//
//  Created by praveen on 10/28/19.
//  Copyright © 2019 focussoftnet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        for i in 1...3 {
//            serverCall(id: i) { (response) in
//                print(response)
//            }
//        }

        
//        serverCall(id: 1) { (response) in
//            print(response)
//            self.serverCall(id: 2) { (response) in
//                print(response)
//                self.serverCall(id: 3) { (response) in
//                    print(response)
//                }
//            }
//        }
        
        
//        let dispatchGroup = DispatchGroup()
//        dispatchGroup.enter()
//        serverCall(id: 1) { (response) in
//            print(response)
//            dispatchGroup.leave()
//        }
//        dispatchGroup.enter()
//        serverCall(id: 2) { (response) in
//            print(response)
//            dispatchGroup.leave()
//        }
//        dispatchGroup.enter()
//        serverCall(id: 3) { (response) in
//            print(response)
//            dispatchGroup.leave()
//        }
//        dispatchGroup.notify(queue: .main) {
//            print("Both functions complete 👍")
//        }
        
    
//        let lock = NSLock()
//        for i in 1...3 {
//            lock.lock()
//            serverCall2(id: i) { (response) in
//               lock.unlock()
//               print(response)
//            }
//        }
        
        getDataFromServer()
    }

    
    //Create a semaphore
    let semaphore = DispatchSemaphore(value: 0)
    
    func getDataFromServer() {
        DispatchQueue(label: "myQueue", qos: .background).async {
            for i in 1...10 {
                self.serverCall(id: i, completionHandler: { (response) in
                    print(response)
                    
                    //Signals free on service return to work for next service
                    self.semaphore.signal()
                })
                //Wait till the service returns
                self.semaphore.wait()
            }
        }
        print("Start Fetching")
    }
    
    func serverCall(id: Int, completionHandler: @escaping(_ string: String) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            completionHandler("Data with id: \(id).")
        }
    }
}
