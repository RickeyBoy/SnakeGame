//
//  ViewController.swift
//  Snake
//
//  Created by Rickey on 2024/5/21.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    /// 游戏场地
    var gameGround = GameView()
    /// 游戏信息view
    var logView = LogView()
    /// 游戏控制
    lazy var logicModel: LogicModel = {
        return LogicModel(gameGround: gameGround, logView: logView)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let xMargin = (UIScreen.screenWidth - (UIScreen.screenWidth / unitEdge - 2) * unitEdge) / 2.0 // 计算边缘预留空间大小，预留 2+ 个格子大小的间距，需要确保宽度被 unitEdge 整除
        // 添加游戏信息
        self.view.addSubview(logView)
        self.logView.snp.makeConstraints { make in
            make.left.equalTo(xMargin)
            make.right.equalTo(-xMargin)
            make.height.equalTo(100)
            make.top.equalTo(60)
        }
        // 添加游戏主场地
        self.view.addSubview(gameGround)
        self.gameGround.snp.makeConstraints { make in
            make.left.equalTo(xMargin)
            make.right.equalTo(-xMargin)
            make.height.equalTo(400)
            make.top.equalTo(self.logView.snp.bottom).offset(20)
        }
        // 添加手势
        self.addSwipeGes()
        // 开始游戏
        self.logicModel.startGame()
    }
    
    // MARK: - 手势处理
    
    public func addSwipeGes() {
        /// 添加四个方向轻扫手势
        let directions: [UISwipeGestureRecognizer.Direction] = [.left, .right, .up, .down]
        directions.forEach { addSwipeGesture(to: $0, action: #selector(swipeGes(ges:)))}
        /// 添加点击手势
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(tapGes(ges:)))
        self.view.addGestureRecognizer(tapGes)
    }

    private func addSwipeGesture(to direction: UISwipeGestureRecognizer.Direction, action: Selector) {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: action)
        swipeGesture.direction = direction
        self.view.addGestureRecognizer(swipeGesture)
    }
    
    @objc private func swipeGes(ges: UISwipeGestureRecognizer) {
        let dir = Direction(swipeGesture: ges)
        self.logicModel.changeTo(dir)
    }
    
    @objc private func tapGes(ges: UITapGestureRecognizer) {
        self.logicModel.clickGes()
    }
}
