//
//  DrawnIconSuccess.swift
//
//  Created by Everton on 24/08/17.
//

import UIKit

public class EPCDrawnIconSuccess: UIView, EPCDrawnIconProtocol {

  public static let suggestedSize = CGSize(width: 95, height: 78)

  public var color = UIColor.white {
    didSet {
      setNeedsDisplay()
    }
  }

  fileprivate var step: Int = 0

  fileprivate var progress: CGFloat = 0

  fileprivate var timer: Timer?

  required public init?(coder aDecoder: NSCoder) {
    fatalError("\(#file) \(#function) not implemented")
  }

  override public init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.clear
    clipsToBounds = false
    layer.masksToBounds = false
    contentMode = .redraw
  }

  override public func draw(_ rect: CGRect) {

    //// loading Group
    //// Bezier Drawing
    let bezierPath = UIBezierPath()
    bezierPath.move(to: CGPoint(x: prop(16.33), y: prop(38.44)))

    if step == 0 {
      bezierPath.addLine(to:
        CGPoint(x: prop(16.33)+((prop(37.5-16.33))*progress),
                y: prop(38.44) + ((prop(60.98-38.44))*progress)
        )
      )
    } else if step == 1 {
      bezierPath.addLine(to: CGPoint(x: prop(37.5), y: prop(60.98)))
      bezierPath.addLine(to:
        CGPoint(x: prop(37.5) + ((prop(79.15-37.5))*progress),
                y: prop(60.98) - ((prop(60.98-15.83))*progress)
        )
      )
    }
    color.setStroke()
    bezierPath.lineWidth = prop(11)
    bezierPath.lineCapStyle = .round
    bezierPath.lineJoinStyle = .round
    bezierPath.stroke()
  }

  fileprivate func refresh() {
    timer?.invalidate()
    timer = Timer.scheduledTimer(timeInterval: 0.001,
                                 target: self,
                                 selector: #selector(updateProgress),
                                 userInfo: nil,
                                 repeats: true
    )
    timer?.fire()
  }

  @objc fileprivate func updateProgress() {
    progress += 0.06
    if progress >= 1 {
      progress = 0
      step += 1
      if step > 1 {
        progress = 1
        step = 1
        timer?.invalidate()
      } else {
        refresh()
      }
    }
    setNeedsDisplay()
  }

  // MARK: - Public

  public func animate() {
    step = 0
    progress = 0
    refresh()
  }
}
