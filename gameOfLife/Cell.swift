//
//  Cell.swift
//  gameOfLife
//
//  Created by Jacob Pashman on 6/20/18.
//  Copyright © 2018 jacobpashman. All rights reserved.
//

import Foundation
import UIKit

class Cell {
    let x: Int
    let y: Int
    var state: Bool
    var view: UIView!
    var live: Bool
    
    init (x: Int, y: Int, state: Bool) {
        self.x = x
        self.y = y
        self.state = state
        self.view = UIView()
        self.live = false
    }
}
