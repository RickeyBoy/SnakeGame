//
//  LandUnit.swift
//  Snake
//
//  Created by Wang Timo on 2024/6/12.
//

import UIKit

/// UnitView 类型
enum UnitViewType {
    case snakeHead /// 蛇头
    case snakeBody /// 蛇身
    case food /// 食物
    case normal /// 空白格子
    
    /// 获取对应的图片
    func generateImage() -> UIImage? {
        switch self {
        case .snakeHead:
            return #imageLiteral(resourceName: "snakeHeader")
        case .snakeBody:
            return #imageLiteral(resourceName: "snakeBody")
        case .food:
            let foodIndex = arc4random_uniform(8)
            return UIImage(named: "food\(foodIndex)")
        case .normal:
            return nil
        }
    }
}
