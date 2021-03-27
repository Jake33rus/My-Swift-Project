//
//  ContainerView.swift
//  ShowingoUIKit
//
//  Created by Евгений Уланов on 21.03.2021.
//

import UIKit

final public class ContainerView<T: UIView>: UIView {
    
    public let contentView: T
    public let offset: UIEdgeInsets
    
    public init(contentView: T,
                offset: UIEdgeInsets = .zero) {
        
        self.contentView = contentView
        self.offset = offset
        
        super.init(frame: .zero)
        
        addSubview(contentView.prepareForAutoLayout())
        contentView.pinEdgesToSuperviewEdges(
            top: offset.top,
            left: offset.left,
            bottom: offset.bottom,
            right: offset.right
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
