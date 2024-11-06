//
//  UnitView.swift
//  Snake
//
//  Created by Wang Timo on 2024/6/12.
//

import UIKit

/// 坐标
struct Pos: Equatable {
    var x: Int
    var y: Int
    
    static func == (lhs: Pos, rhs: Pos) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
    
    /// 根据方向获取下一个坐标位置
    func nextPos(direction: Direction) -> Pos {
        switch direction {
        case .Up:
            return Pos(x: self.x, y: self.y - 1)
        case .Down:
            return Pos(x: self.x, y: self.y + 1)
        case .Left:
            return Pos(x: self.x - 1, y: self.y)
        case .Right:
            return Pos(x: self.x + 1, y: self.y)
        }
    }
}

class UnitView: UIImageView {
    var unitType: UnitViewType = .normal {
        didSet {
            self.layoutSubviews()
        }
    }
    var pos: Pos = Pos(x: 0, y: 0)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .clear
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.5
        self.image = self.unitType.generateImage()
    }
}
