//
//  DrawnIconSpinner.swift
//
//  Created by Everton on 24/08/17.
//

import UIKit

public protocol EPCDrawnIconSpinnerProtocol {
  
  var state: EPCDrawnIconSpinner.State { get set }
  
  var color: UIColor { get set }
  
  var colorError: UIColor { get set }
  
  var speed: CGFloat { get set }
  
  func setSuccess()
  
  func setError()
  
  func start()
  
  func stop()
  
  func setProgressCompleted()
}

public class EPCDrawnIconSpinner: UIView, EPCDrawnIconSpinnerProtocol {
  
  public enum State: Int {
    case loading
    case success
    case error
  }
  
  public var state: EPCDrawnIconSpinner.State = .loading
  
  public var color = UIColor(red: 0.004, green: 0.553, blue: 0.416, alpha: 1.000) {
    didSet {
      setNeedsDisplay()
    }
  }
  
  public var colorError = UIColor(red: 0.710, green: 0.341, blue: 0.345, alpha: 1.000) {
    didSet {
      setNeedsDisplay()
    }
  }
  
  public var speed: CGFloat = 1
  
  fileprivate var progress: CGFloat = 0
  
  fileprivate var pathNumber: Int = 0
  
  fileprivate var timer: Timer?
  
  fileprivate let maxPaths: Int = 3
  
  fileprivate var lineWidth: CGFloat = 11
  
  fileprivate var time: TimeInterval!
  
  fileprivate let pStart: CGFloat = 200
  
  fileprivate let lap: CGFloat = 360
  
  fileprivate var iconSuccess: (UIView & EPCDrawnIconProtocol)!
  
  fileprivate var iconError: (UIView & EPCDrawnIconProtocol)!
  
  override public var frame: CGRect {
    set(value) {
      let maxValue = max(value.size.width, value.size.height)
      var value = value
      value.size.width = maxValue
      value.size.height = maxValue
      super.frame = value
      
      lineWidth = prop(11)
    }
    get {
      return super.frame
    }
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("\(#file) \(#function) not implemented")
  }
  
  public override func layoutSubviews() {
    super.layoutSubviews()
  }
  
  override public init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.clear
    clipsToBounds = true
    contentMode = .redraw
    
    drawSuccessIcon()
    drawErrorIcon()
    iconError.isHidden = true
    iconSuccess.isHidden = false
  }
  
  override public func draw(_ rect: CGRect) {
    super.draw(rect)
    var ovalPath: UIBezierPath?
    let ovalRect = rect.insetBy(dx: lineWidth/2, dy: lineWidth/2)
    
    if state == .error {
      colorError.setStroke()
    } else {
      color.setStroke()
    }
    
    if state == .loading {
      
      UIGraphicsGetCurrentContext()?.clear(rect)
      
      if pathNumber == 0 {
        ovalPath = path0(ovalRect)
      } else if pathNumber == 1 {
        ovalPath = path1(ovalRect)
      } else if pathNumber == 2 {
        ovalPath = path2(ovalRect)
      }
      
      ovalPath?.lineWidth = lineWidth
    } else {
      if progress < 1 {
        drawPathCompleted(ovalRect)
      }
      else {
        ovalPath = pathCompleted(ovalRect)
        ovalPath?.lineWidth = lineWidth
        layer.cornerRadius = 0
        if state == .error {
          colorError.setFill()
        }
        else {
          color.setFill()
        }
        ovalPath?.fill()
      }
    }
    
    ovalPath?.lineCapStyle = .round
    ovalPath?.stroke()
  }
  
  fileprivate func prop(_ val: CGFloat) -> CGFloat {
    return (frame.size.height * val)/180
  }
  
  fileprivate func path0(_ ovalRect: CGRect) -> UIBezierPath {
    
    let start = pStart + (10 * progress) // 200 -> 240
    let end = pStart + 10 + ((lap - 25) * progress) // -155 -> -170
    
    let ovalPath = UIBezierPath()
    ovalPath.addArc(withCenter: CGPoint(x: ovalRect.midX, y: ovalRect.midY),
                    radius: ovalRect.width / 2,
                    startAngle: start * CGFloat.pi/180,
                    endAngle: end * CGFloat.pi/180, clockwise: true)
    return ovalPath
  }
  
  fileprivate func path1(_ ovalRect: CGRect) -> UIBezierPath {
    
    let start = pStart + 10 + (50 * progress) // -165 -> -135
    let end = pStart + 10 + (lap - 25) + (10 * progress) // -155 -> -170
    
    let ovalPath = UIBezierPath()
    ovalPath.addArc(withCenter: CGPoint(x: ovalRect.midX, y: ovalRect.midY),
                    radius: ovalRect.width / 2,
                    startAngle: start * CGFloat.pi/180,
                    endAngle: end * CGFloat.pi/180, clockwise: true)
    return ovalPath
    
  }
  
  fileprivate func path2(_ ovalRect: CGRect) -> UIBezierPath {
    
    let start = pStart + 10 + 50 + (300 * progress) // -165 -> -135
    let end = pStart + 10 + (lap - 25) + 10 + (10 * progress) // -155 -> -170
    
    let ovalPath = UIBezierPath()
    ovalPath.addArc(withCenter: CGPoint(x: ovalRect.midX, y: ovalRect.midY),
                    radius: ovalRect.width / 2,
                    startAngle: start * CGFloat.pi/180,
                    endAngle: end * CGFloat.pi/180, clockwise: true)
    return ovalPath
  }
  
  fileprivate func refresh() {
    if pathNumber == 0 {
      time = 0.003
    } else if pathNumber == 1 {
      time = 0.007
    } else if pathNumber == 2 {
      time = 0.003
    }
    timer?.invalidate()
    timer = Timer.scheduledTimer(timeInterval: time,
                                 target: self,
                                 selector: #selector(updateProgress),
                                 userInfo: nil,
                                 repeats: true)
    timer?.fire()
  }
  
  @objc fileprivate func updateProgress() {
    progress += (0.015 * speed)
    
    if state == .success || state == .error {
      progress += 0.01
    }
    
    if progress >= 1 {
      progress = 0
      pathNumber += 1
      if pathNumber >= maxPaths {
        pathNumber = 0
      }
      if state == .success {
        progress = 1
        timer?.invalidate()
        iconSuccess.isHidden = false
        iconSuccess.animate()
      } else if state == .error {
        progress = 1
        timer?.invalidate()
        iconError.isHidden = false
        iconError.animate()
      } else {
        refresh()
      }
    }
    setNeedsDisplay()
  }
  
  fileprivate func pathCompleted(_ ovalRect: CGRect) -> UIBezierPath {
    let start = pStart
    let end = pStart + lap
    
    let ovalPath = UIBezierPath()
    ovalPath.addArc(withCenter: CGPoint(x: ovalRect.midX, y: ovalRect.midY),
                    radius: ovalRect.width / 2,
                    startAngle: start * CGFloat.pi/180,
                    endAngle: end * CGFloat.pi/180, clockwise: true)
    return ovalPath
  }
  
  fileprivate func drawPathCompleted(_ ovalRect: CGRect) {
    
    var size: CGFloat = ovalRect.size.width
    
    let current = size*(1-progress)
    
    var pos: CGFloat = lineWidth/2
    
    while size > current {
      let ovalPath = UIBezierPath(ovalIn: CGRect(x: pos, y: pos, width: size, height: size))
      ovalPath.lineCapStyle = .round
      ovalPath.lineWidth = lineWidth
      ovalPath.stroke()
      let decr = lineWidth/2
      size -= decr
      pos += decr/2
    }
  }
  
  fileprivate func drawSuccessIcon() {
    var fra = CGRect.zero
    fra.size = CGSize(
      width: prop(EPCDrawnIconSuccess.suggestedSize.width),
      height: prop(EPCDrawnIconSuccess.suggestedSize.height)
    )
    let ico = EPCDrawnIconSuccess(frame: fra)
    iconSuccess = ico
    addIcon(ico)
  }
  
  fileprivate func drawErrorIcon() {
    var fra = CGRect.zero
    fra.size = CGSize(
      width: prop(EPCDrawnIconError.suggestedSize.width),
      height: prop(EPCDrawnIconError.suggestedSize.height)
    )
    let ico = EPCDrawnIconError(frame: fra)
    iconError = ico
    addIcon(ico)
  }
  
  fileprivate func addIcon(_ icon: UIView & EPCDrawnIconProtocol) {
    icon.center = CGPoint(
      x: CGFloat(Int(frame.size.width/2)),
      y: CGFloat(Int(frame.size.height/2))
    )
    icon.autoresizingMask = [
      .flexibleWidth,
      .flexibleHeight,
      .flexibleTopMargin,
      .flexibleLeftMargin,
      .flexibleRightMargin,
      .flexibleBottomMargin
    ]
    addSubview(icon)
  }
  
  // MARK: - Public
  
  public func setSuccess() {
    iconError.isHidden = true
    timer?.invalidate()
    state = .success
    
    pathNumber = 0
    progress = 0
    
    refresh()
    
    setNeedsDisplay()
  }
  
  public func setError() {
    iconSuccess.isHidden = true
    timer?.invalidate()
    state = .error
    
    pathNumber = 0
    progress = 0
    
    refresh()
    
    setNeedsDisplay()
  }
  
  public func start() {
    iconError.isHidden = true
    iconSuccess.isHidden = true
    progress = 0
    pathNumber = 0
    refresh()
  }
  
  public func stop() {
    timer?.invalidate()
  }
  
  public func setProgressCompleted() {
    timer?.invalidate()
    pathNumber = 1
    progress = 0.4
    setNeedsDisplay()
  }
}

