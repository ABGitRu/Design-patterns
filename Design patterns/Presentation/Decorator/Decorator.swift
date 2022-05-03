//
//  Decorator.swift
//  Design patterns
//
//  Created by Mac on 19.04.2022.
//

import UIKit

/// протокол вью которую необходимо декорировать
protocol ViewElementProtocol {
    var view: UIView { get set }
}

/// класс вью которую можно декорировать
final class UpgradableView: ViewElementProtocol {
    var view: UIView

    init(view: UIView) {
        self.view = view
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = .red
    }
}

/// Класс декоратор
class Decorator: ViewElementProtocol {
    var view: UIView
    
    init(element: ViewElementProtocol) {
        self.view = element.view
    }
}

/// класс декоратор границ вью
final class UpgradeBorder: Decorator {
    
    init(element: ViewElementProtocol, borderColor: CGColor, borderWidth: CGFloat) {
        super.init(element: element)
        self.view.layer.borderColor = borderColor
        self.view.layer.borderWidth = borderWidth
    }
}

/// класс декоратор радиуса вью
final class UpgradeRadius: Decorator {
    init(element: ViewElementProtocol, cornerRadius: CGFloat) {
        super.init(element: element)
        self.view.layer.cornerRadius = cornerRadius
    }
}

/// класс декоратор цвета фона вью
final class UpgradeBackGroundColor: Decorator {
    init(element: ViewElementProtocol, color: UIColor) {
        super.init(element: element)
        self.view.backgroundColor = color
    }
}

/// класс декоратор анимации вью
final class UpgradeWithAnimation: Decorator {
    override init(element: ViewElementProtocol) {
        super.init(element: element)
        UIView.animateKeyframes(withDuration: 3.0, delay: 0, options: .autoreverse) {
            self.view.transform = CGAffineTransform(scaleX: 2, y: 2)
        }
    }
}
