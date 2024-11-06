//
//  GameState.swift
//  Snake
//
//  Created by Wang Timo on 2024/6/13.
//

import Foundation

/// 游戏状态
enum GameState {
    case paused
    case running
    case gameover
    
    var description: String {
        switch self {
        case .paused:
            return "暂停"
        case .running:
            return "游戏中"
        case .gameover:
            return "游戏结束"
        }
    }
}
