//
//  BasicModal.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2017-11-17.
//  Copyright © 2017 Brandon Danis. All rights reserved.
//

import Foundation
import UIKit

class BasicModal : UIViewController {
    
    var duration : Float
    var mainString : String
    var substring : String?
    var icon : String?
    
    public init(duration : Float = 2.0, mainString main : String, substring sub : String?, icon : String?){
        self.duration = duration
        self.mainString = main
        self.substring = sub
        self.icon = icon
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("View just appeared!")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("View just disappeared!")
    }
    
}
