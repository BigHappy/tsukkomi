//
//  ViewController.swift
//  tsukkomi-
//
//  Created by 荒川陸 on 2016/08/06.
//  Copyright © 2016年 Riku Arakawa. All rights reserved.
//

import UIKit
import Alamofire
import CoreMotion

class ViewController: UIViewController {
    
    let motionManager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        motionManager.accelerometerUpdateInterval = 0.1
        let accelerometerHandler:CMAccelerometerHandler = {
            (data: CMAccelerometerData?, error: NSError?) -> Void in
            
            guard let data = data else {return}
            if data.acceleration.x > 3.0 || data.acceleration.z > 3.0 {
                print("x: \(data.acceleration.x) y: \(data.acceleration.y) z: \(data.acceleration.z)")
                
                Alamofire.request(.POST, "https://biribiri.herokuapp.com/straights", parameters: nil)
                    .response { (request, response, data, error) in
                        print(request)
                        print(response)
                        print(error)
                }
            }
        }
        
        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: accelerometerHandler)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
