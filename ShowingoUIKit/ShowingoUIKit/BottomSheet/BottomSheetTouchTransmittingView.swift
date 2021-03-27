//
//  BottomSheetTouchTransmittingView.swift
//  ShowingoUIKit
//
//  Created by Евгений Уланов on 21.03.2021.
//

import UIKit

/// Вспомогательный класс для прокидывания тапов во вью презентующего контейнера
class BottomSheetTouchTransmittingView: UIView {

    var touchReceivingView: UIView?

    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let touchReceivingView = touchReceivingView {
            let convertedView = convert(point, to: touchReceivingView)
            return touchReceivingView.hitTest(convertedView, with: event)
        } else {
            return super.hitTest(point, with: event)
        }
    }

}
