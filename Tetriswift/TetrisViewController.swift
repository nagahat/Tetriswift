//
//  TetrisViewController.swift
//  Tetriswift
//
//  Created by nagahara on 2015/07/25.
//  Copyright (c) 2015年 ___Takanori Nagahara___. All rights reserved.
//

import UIKit

class TetrisViewController: UIViewController {
    
    @IBOutlet weak var StatButton: UIButton!
    let Rate: Int = 30
    
    var factory: TetriminoFactory?
    var timeCount: Int = 0
    var level: Int = 1
    var tetrimino: Tetrimino?
    var game: Game?
    var world: World?
    
    @IBAction func Start(sender: AnyObject) {
        println("w, h: \(self.view.frame)")
        game = Game(width: self.view.frame.width, height: self.view.frame.height)
        world = game!.world
        factory = TetriminoFactory(game: game!)
        tetrimino = factory!.create(self.view)
        game!.start()
        NSTimer.scheduledTimerWithTimeInterval(Double(1.0 / Double(Rate)), target: self, selector: "onUpdate:", userInfo: nil, repeats: true)
        StatButton.hidden = true
    }
    
    
    func isTimeToMove(count: Int) -> Bool {
        if (count < Rate - (level - 1)) {
            return false
        }
        
        return true
    }
    
    func onUpdate(timer: NSTimer) {
        self.timeCount += 1
        
        if (self.isTimeToMove(timeCount)) {
            tetrimino!.updateFromDiff(CGPointMake(0, Game.unit))
            self.timeCount = 0
        }
        
        let isBound: Bool = tetrimino!.moveTo(world!)
        if (isBound) {
            world!.putTetrimino(tetrimino!)
            world!.removeLine()
            tetrimino!.dispose()
            tetrimino = factory!.create(self.view)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
