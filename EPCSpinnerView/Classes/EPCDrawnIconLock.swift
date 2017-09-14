//
//  DrawnIconLock.swift
//
//  Created by Everton on 24/08/17.
//

import UIKit

public class EPCDrawnIconLock: UIView, EPCDrawnIconProtocol {

  public static let suggestedSize = CGSize(width: 46, height: 72)

  public var color = UIColor(red: 0.004, green: 0.553, blue: 0.416, alpha: 1.000) {
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

  fileprivate func propH(_ val: CGFloat) -> CGFloat {
    return (frame.size.height * val)/EPCDrawnIconLock.suggestedSize.height
  }

  fileprivate func propW(_ val: CGFloat) -> CGFloat {
    return (frame.size.width * val)/EPCDrawnIconLock.suggestedSize.width
  }

  override public func draw(_ rect: CGRect) {

    //// Bezier 2 Drawing
    let bezier2Path = UIBezierPath()
    bezier2Path.move(to: CGPoint(x: propW(40.77), y: propH(70.49)))
    bezier2Path.addLine(to: CGPoint(x: propW(4.68), y: propH(70.49)))
    bezier2Path.addCurve(to: CGPoint(x: propW(2.08), y: propH(69.12)),
                         controlPoint1: CGPoint(x: propW(3.64), y: propH(70.49)),
                         controlPoint2: CGPoint(x: propW(2.67), y: propH(69.98)))
    bezier2Path.addCurve(to: CGPoint(x: propW(1.73), y: propH(66.2)),
                         controlPoint1: CGPoint(x: propW(1.49), y: propH(68.26)),
                         controlPoint2: CGPoint(x: propW(1.36), y: propH(67.17)))
    bezier2Path.addLine(to: CGPoint(x: propW(13.24), y: propH(35.8)))
    bezier2Path.addCurve(to: CGPoint(x: propW(4.05), y: propH(19.67)),
                         controlPoint1: CGPoint(x: propW(7.64), y: propH(32.46)),
                         controlPoint2: CGPoint(x: propW(4.05), y: propH(26.32)))
    bezier2Path.addCurve(to: CGPoint(x: propW(22.73), y: propH(0.92)),
                         controlPoint1: CGPoint(x: propW(4.05), y: propH(9.33)),
                         controlPoint2: CGPoint(x: propW(12.43), y: propH(0.92)))
    bezier2Path.addCurve(to: CGPoint(x: propW(41.4), y: propH(19.67)),
                         controlPoint1: CGPoint(x: propW(33.02), y: propH(0.92)),
                         controlPoint2: CGPoint(x: propW(41.4), y: propH(9.33)))
    bezier2Path.addCurve(to: CGPoint(x: propW(32.21), y: propH(35.8)),
                         controlPoint1: CGPoint(x: propW(41.4), y: propH(26.32)),
                         controlPoint2: CGPoint(x: propW(37.81), y: propH(32.46)))
    bezier2Path.addLine(to: CGPoint(x: propW(43.72), y: propH(66.2)))
    bezier2Path.addCurve(to: CGPoint(x: propW(43.37), y: propH(69.12)),
                         controlPoint1: CGPoint(x: propW(44.09), y: propH(67.17)),
                         controlPoint2: CGPoint(x: propW(43.96), y: propH(68.26)))
    bezier2Path.addCurve(to: CGPoint(x: propW(40.77), y: propH(70.49)),
                         controlPoint1: CGPoint(x: propW(42.78), y: propH(69.98)),
                         controlPoint2: CGPoint(x: propW(41.81), y: propH(70.49)))
    bezier2Path.close()
    color.setFill()
    bezier2Path.fill()

  }

  public func animate() {

  }
}
