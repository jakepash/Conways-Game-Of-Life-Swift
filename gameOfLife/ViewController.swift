//
//  ViewController.swift
//  gameOfLife
//
//  Created by Jacob Pashman on 6/20/18.
//  Copyright © 2018 jacobpashman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let lifeSize = 15
    var grid = [Cell]()
    
    var timer = Timer()
    
    var generations = 0

    @IBOutlet weak var generationsLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for x in 0...(23) {
            for y in 0...(40) {
                grid.append(Cell(x: x, y: y, state: false))
                print(y)
            }
        }
        
        
        for i in 0...grid.count-1 {
            let cell = grid[i]
            cell.view.frame = CGRect(x: cell.x*lifeSize+7, y: cell.y*lifeSize+100, width: lifeSize, height: lifeSize)
            resetColor(cell: cell)
            cell.view.tag = i
            
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            cell.view.addGestureRecognizer(recognizer)
            
            view.addSubview(cell.view)
        }
        
    }
    
    func resetColor(cell: Cell) {
        if cell.x % 2 == 0 && cell.y % 2 == 0 || cell.x % 2 == 1 && cell.y % 2 == 1{
            cell.view.backgroundColor = UIColor.darkGray
        } else {
            cell.view.backgroundColor = UIColor.lightGray
        }
    }
    
    @objc func handleTap(sender: UIGestureRecognizer) {
        // handling code
        let senderCell = grid[(sender.view?.tag)!]
        if senderCell.state == false {
            senderCell.state = true
            senderCell.view.backgroundColor = UIColor.green
        } else {
            senderCell.state = false
            resetColor(cell: senderCell)
        }
        
        
    }
    
    @objc func runGeneration() {
        for i in 0...grid.count-1 {
            let cell = grid[i]
            let neighbors = checkForNeighbors(cell: cell)
            if cell.state == true {
                print("number of neighbors \(neighbors)")
                if neighbors < 2 {
                   cell.live = false
                }
                if neighbors == 2 || neighbors == 3 {
                    cell.live = true
                }
                if neighbors > 3 {
                    cell.live = false
                }
                
            } else if neighbors == 3 {
                cell.live = true
            }
            
        }
        
        for j in 0...grid.count-1 {
            let cell = grid[j]
            if cell.live == true {
                cell.state = true
                cell.view.backgroundColor = UIColor.green
            } else {
                cell.state = false
                resetColor(cell: cell)
            }
        }
        generations += 1
        generationsLabel.text = String(generations)
    }
    func checkForNeighbors(cell: Cell) -> Int {
        var neighbors = 0
        for i in 0...grid.count-1 {
            if grid[i].state == true {
                if grid[i].x == cell.x && grid[i].y == cell.y+1 { //below
                    neighbors += 1
                }
                if grid[i].x == cell.x && grid[i].y == cell.y-1 { //above
                    neighbors += 1
                }
                if grid[i].y == cell.y && grid[i].x == cell.x+1 { //right
                    neighbors += 1
                }
                if grid[i].y == cell.y && grid[i].x == cell.x-1 { //left
                    neighbors += 1
                }
                if grid[i].y == cell.y+1 && grid[i].x == cell.x+1 { //bottom right
                    neighbors += 1
                }
                if grid[i].y == cell.y+1 && grid[i].x == cell.x-1 { //bottom left
                    neighbors += 1
                }
                if grid[i].y == cell.y-1 && grid[i].x == cell.x+1 { //top right
                    neighbors += 1
                }
                if grid[i].y == cell.y-1 && grid[i].x == cell.x-1 { //top left
                    neighbors += 1
                }
            }
        }
        
        return neighbors
    }

    
    @IBAction func startButtonPressed(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(runGeneration), userInfo: nil, repeats: true)
    }
    
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        timer.invalidate()
        for i in 0...grid.count-1 {
            let cell = grid[i]
            cell.state = false
            resetColor(cell: cell)
        }
        generations = 0
        generationsLabel.text = "0"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

