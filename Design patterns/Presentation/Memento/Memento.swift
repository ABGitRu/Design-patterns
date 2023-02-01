//
//  Memento.swift
//  Design patterns
//
//  Created by Mac on 02.05.2022.
//

import UIKit

/// Обьект точка
struct Point {
    /// координата по оси x
    var x: CGFloat
    /// координата по оси y
    var y: CGFloat
    /// цвет точки
    var color: UIColor

    init(x: CGFloat, y: CGFloat) {
        self.x = x
        self.y = y
        self.color = .green
    }
}

/// краситель
class Painter {
    /// массив точек
    private var points: [Point] = []
    
    /// добавить точку
    /// - Parameters:
    /// - point: точка
    func addPoint(point: Point) {
        points.append(point)
    }

    /// добавить точки на вью
    /// - Parameters:
    /// - view: вью на которую будем добавлять точки
    func printPoints(in view: UIView) {
        for v in view.subviews {
            v.removeFromSuperview()
        }

        for p in points {
            let v = UIView(frame: CGRect(x: p.x, y: p.y, width: 3, height: 3))

            v.backgroundColor = p.color
            
            view.addSubview(v)
        }
    }

    /// сохранить текущиие точки
    func save() -> PainterMemento {
        return PainterMemento(points: self.points)
    }

    /// загрузить сохраненые точки
    func load(state: PainterMemento) {
        self.points = state.points
    }
}

/// объект который будет хранить точки
class PainterMemento {
    var points: [Point]
    init(points: [Point]) {
        self.points = points
    }
}

/// хранить точек
class CarrierState {
    /// состояние точек
    var state: PainterMemento?

    /// краситель
    var painter: Painter

    init(painter: Painter) {
        self.painter = painter
    }

    /// сохранить текущее состояние точек
    func save() {
        state = painter.save()
    }

    /// загрузить сохраненное состояние точек
    func load() {
        guard let state = state else { return }
        painter.load(state: state)
    }
}
