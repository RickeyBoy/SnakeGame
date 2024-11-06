//
//  Directions.swift
//  Snake
//
//  Created by Rickey on 2024/6/11.
//

import UIKit

/// 游戏方向
enum Direction {
    case Up
    case Down
    case Left
    case Right
    
    /// 是否是相反方向
    func isReverse(to direction: Direction) -> Bool {
        switch self {
        case .Up: return direction == .Down
        case .Left: return direction == .Right
        case .Down: return direction == .Up
        case .Right: return direction == .Left
        }
    }
    
    /// 根据手势方向进行初始化
    init(swipeGesture: UISwipeGestureRecognizer) {
        switch swipeGesture.direction {
        case .up:
            self = .Up
        case .down:
            self = .Down
        case .left:
            self = .Left
        case .right:
            self = .Right
        default:
            // Providing a default value if the direction is somehow not recognized
            self = .Up
        }
    }
}
