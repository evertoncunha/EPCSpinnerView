//
//  DrawnIconError.swift
//
//  Created by Everton on 24/08/17.
//

import UIKit

public class EPCDrawnIconError: UIView, EPCDrawnIconProtocol {

  public static let suggestedSize: CGSize = CGSize(width: 72, height: 72)

  public var color = UIColor.white {
    didSet {
      setNeedsDisplay()
    }
  }

  required public init?(coder aDecoder: NSCoder) {
    fatalError("\(#file) \(#function) not implemented")
  }

  override public init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.clear
    contentMode = .redraw
  }

  override public func draw(_ rect: CGRect) {

    let lineWidth = prop(9)

    //// Bezier Drawing
    let bezierPath = UIBezierPath()
    bezierPath.move(to: CGPoint(x: prop(60.34), y: prop(13.28)))
    bezierPath.addLine(to: CGPoint(x: prop(13.56), y: prop(59.71)))
    color.setStroke()
    bezierPath.lineWidth = lineWidth
    bezierPath.lineCapStyle = .round
    bezierPath.lineJoinStyle = .round
    bezierPath.stroke()

    //// Bezier 2 Drawing
    let bezier2Path = UIBezierPath()
    bezier2Path.move(to: CGPoint(x: prop(13.74), y: prop(13.11)))
    bezier2Path.addLine(to: CGPoint(x: prop(60.17), y: prop(59.89)))
    color.setStroke()
    bezier2Path.lineWidth = lineWidth
    bezier2Path.lineCapStyle = .round
    bezier2Path.lineJoinStyle = .round
    bezier2Path.stroke()
  }

  // MARK: - Public

  public func animate() {
    transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    UIView.animate(withDuration: 0.1) { [weak self] in
      self?.transform = CGAffineTransform(scaleX: 1, y: 1)
    }
  }
}
