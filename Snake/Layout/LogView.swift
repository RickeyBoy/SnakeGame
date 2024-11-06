//
//  GameLogView.swift
//  Snake
//
//  Created by Rickey on 2024/6/11.
//

import UIKit
import SnapKit

class LogView: UIView {
    /// 更新数据
    public func updateContent(_ text: String) {
        self.contentLabel.text = text
    }
    
    private let contentLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.contentLabel.numberOfLines = 0
        self.contentLabel.textAlignment = .center
        self.contentLabel.textColor = .black
        self.addSubview(contentLabel)
        self.contentLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
