//
//  LogicModel.swift
//  Snake
//
//  Created by Rickey on 2024/6/12.
//

import UIKit

class LogicModel {
    /// 游戏场地
    private weak var gameGround: GameView?
    /// 游戏信息
    private weak var logView: LogView?
    /// 定时器
    private var timer = Timer()
    /// 游戏状态
    private var state: GameState = .paused
    /// 蛇的移动方向
    private var snakeMoveDir: Direction = .Down
    /// 得分：已经吃到的食物个数
    private var score: Int = 0
    
    init(gameGround: GameView, logView: LogView) {
        self.logView = logView
        self.gameGround = gameGround
    }
    
    /// 点击事件
    func clickGes() {
        if self.state == .running {
            self.pauseGame()
        } else {
            self.startGame()
        }
    }
    
    /// 改变蛇的方向
    func changeTo(_ direction: Direction) {
        if snakeMoveDir.isReverse(to: direction) {
            // 反方向不做处理
            return
        }
        snakeMoveDir = direction
    }
    
    // MARK: - State
    
    /// 开始游戏
    public func startGame() {
        self.timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        self.state = .running
        self.refreshLogInfo()
    }
    
    /// 暂停游戏
    private func pauseGame() {
        self.state = .paused
        self.timer.invalidate()
        self.refreshLogInfo()
    }
    
    /// 结束游戏
    private func stopGame() {
        self.state = .gameover
        self.timer.invalidate()
        self.refreshLogInfo()
    }
    
    // MARK: - Move
    
    @objc private func timerAction() {
        self.moveSnake()
        self.refreshLogInfo()
    }
    
    /// 移动蛇
    private func moveSnake() {
        guard let gameGround = self.gameGround, let snakeHeader = gameGround.snakeBodys.first else { return }
        let nextPos = snakeHeader.pos.nextPos(direction: self.snakeMoveDir)
        // 判断是否游戏结束了
        if isGameOver(header: nextPos) {
            self.stopGame()
            return
        }
        // 判断是否吃到东西了
        let foodEaten = nextPos == gameGround.food?.pos
        if foodEaten {
            self.score += 1
            gameGround.initialFoods()
        }
        // 移动头部
        let newHeader = gameGround.getUnit(by: nextPos)
        newHeader.unitType = .snakeHead
        gameGround.snakeBodys.insert(newHeader, at: 0)
        // 重置旧头部
        snakeHeader.unitType = .snakeBody
        // 如果没有吃到东西，就移除尾部
        if !foodEaten, let snakeFooter = gameGround.snakeBodys.last {
            snakeFooter.unitType = .normal
            gameGround.snakeBodys.removeLast()
        }
    }
    
    /// 是否游戏结束了
    private func isGameOver(header: Pos) -> Bool {
        guard let gameGround = self.gameGround else { return true }
        // 检查是否撞墙
        if gameGround.outOfBoundary(header) {
            return true
        }
        // 检查是否撞到自身
        if gameGround.snakeBodys.contains(where: { $0.pos == header }) {
            return true
        }
        return false
    }
    
    // MARK: - Description
    
    private func refreshLogInfo() {
        guard let logView = self.logView else { return }
        let info = """
        \(self.state.description)
        得分:\(self.score)
        """
        logView.updateContent(info)
    }
}
