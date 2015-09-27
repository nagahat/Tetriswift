//
//  Block.swift
//  Tetriswift
//
//  Created by nagahara on 2015/08/15.
//  Copyright (c) 2015年 ___Takanori Nagahara___. All rights reserved.
//

import UIKit

class Block: UIView {
    var dest: CGPoint = CGPointZero
    var tetrimino: Tetrimino?
    var isBound: Bool = false
    var isStopped: Bool = false
    
    var origin_w: (row: Int, column: Int) {
        get {
            return Game.convert(self.frame.origin)
        }
    }
    
    init () {
        super.init(frame: CGRectZero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init (o: CGPoint, c: UIColor, t: Tetrimino) {
        self.tetrimino = t
        super.init(frame: CGRectMake(o.x, o.y, Game.unit, Game.unit))
        self.backgroundColor = c
        self.reset()
        self.addDoubleTap("doubleTapped:")
    }
    
    deinit {
        dispose()
    }
    
    func dispose() {
        self.removeFromSuperview()
    }
    
    func hasUpdated() -> Bool {
        return !CGPointEqualToPoint(dest, self.frame.origin)
    }
    
    func moveTo(w: World) {
        let dst = Game.convert(self.dest)
        //let cur = Game.convert(self.frame.origin)
        print("origin: \(self.frame.origin)")
        print("dest: \(self.dest)")
        self.isBound = true
        if (w.isMoved(dst)) {
            print("Move")
            translate(self.dest - self.frame.origin)
            self.isBound = w.isBound(dst)
        }
    }
    
    func translate(p: CGPoint) {
        self.transform = CGAffineTransformTranslate(self.transform, p.x , p.y)
    }
    
    func reset() {
        dest = self.frame.origin
    }
    
    func rightRotate() {
        
    }
    
    func leftRotate() {
        
    }
    
    func getDiff () -> CGPoint {
        return self.frame.origin - CGPointMake(0, 0)
    }
    
    func stop() {
        self.reset()
        self.isStopped = true
    }
    
    func setDestinationFromDiff(diff: CGPoint) {
        self.dest = self.frame.origin + diff
        print("set dest \(self.dest)")
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            self.update(touch.locationInView(self.superview))
        }
    }
    
    func addDoubleTap(selector: Selector) {
        let doubleTap = UITapGestureRecognizer(target: self, action: selector)
        doubleTap.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTap)
    }
    
    func doubleTapped(sender: UITapGestureRecognizer)
    {
        print("TTTTTTTTTTTT")
        print(tetrimino!.game.height)
        print(tetrimino!.game.width)
        print(self.frame.height)
        self.update(CGPointMake(0, tetrimino!.game.height))
    }
    
    func update(dest: CGPoint) {
        print("$$$$$$$$$ \(dest)")
        let p = Game.normalize(dest, current: self.tetrimino!.point)
        self.tetrimino!.update(p)
    }
    
    /*
    func normalize(p: CGFloat, max: CGFloat) -> CGFloat {
    let ret = Game.unit * floor(p / Game.unit)
    if (ret < 0) {
    return 0
    } else if (max < ret) {
    // tetriminoの形状から正しいmaxを返す
    return max
    } else {
    return ret
    }
    }
    
    private func normalize(loc: CGPoint) -> CGPoint {
    let p = Game.convert(loc)
    //let x = normalize(loc.x, max: tetrimino!.game.width - self.frame.width)
    //let y = normalize(loc.y, max: tetrimino!.game.height - self.frame.height)
    return CGPointMake(p.row * , y)
    }
    */
}
