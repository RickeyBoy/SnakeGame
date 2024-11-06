//
//  GameView.swift
//  Snake
//
//  Created by Wang Timo on 2024/6/12.
//

import UIKit
import SnapKit

/// 游戏方格宽度
let unitEdge: CGFloat = 15

class GameView: UIView {
    /// 棋盘地图
    private var mapArrays = [[UnitView]]()
    /// 蛇
    var snakeBodys = [UnitView]()
    /// 食物
    var food: UnitView? = nil
    
    /// 初始化食物
    public func initialFoods() {
        let x = arc4random_uniform(UInt32(self.rowCount))
        let y = arc4random_uniform(UInt32(self.columnCount))
        self.food = self.mapArrays[Int(x)][Int(y)]
        self.food?.unitType = .food
    }
    
    /// 根据坐标点获取 UnitView
    public func getUnit(by position: Pos) -> UnitView {
        return self.mapArrays[position.x][position.y]
    }
    
    /// 是否超出边界了
    public func outOfBoundary(_ position: Pos) -> Bool {
        if position.x < 0 || position.x >= self.rowCount || position.y < 0 || position.y >= self.columnCount {
            return true
        }
        return false
    }
    
    // MARK: - Init
    
    /// 一行存储的box数量
    private var rowCount: Int = 0
    /// 一列存储的box数量
    private var columnCount: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 1
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutBoxes()
        self.initialSnakeBodys()
        self.initialFoods()
    }
    
    // MARK: - Layout
    
    /// 布局boxes
    private func layoutBoxes() {
        self.rowCount = Int(self.bounds.size.width / unitEdge)
        self.columnCount = Int(self.bounds.size.height / unitEdge)
        let rowEdgeMargin: CGFloat = (self.bounds.size.width - unitEdge * CGFloat(self.rowCount)) * 0.5
        let columnEdgeMargin: CGFloat = (self.bounds.size.height - unitEdge * CGFloat(self.columnCount)) * 0.5
        
        for row in 0..<self.rowCount {
            self.mapArrays.insert([], at: row)
            for column in 0..<self.columnCount {
                let x = CGFloat(row) * unitEdge + rowEdgeMargin
                let y = CGFloat(column) * unitEdge + columnEdgeMargin
                let box = UnitView(frame: CGRect(x: x, y: y, width: unitEdge, height: unitEdge))
                box.pos.x = row
                box.pos.y = column
                self.mapArrays[row].insert(box, at: column)
                self.addSubview(box)
            }
        }
    }
    
    /// 初始化蛇数组
    private func initialSnakeBodys() {
        self.snakeBodys.append(self.mapArrays[7][5])
        self.mapArrays[7][5].unitType = .snakeHead
        self.snakeBodys.append(self.mapArrays[6][5])
        self.mapArrays[6][5].unitType = .snakeBody
        self.snakeBodys.append(self.mapArrays[5][5])
        self.mapArrays[5][5].unitType = .snakeBody
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
