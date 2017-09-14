//
//  SpinnerView.swift
//
//  Created by Everton on 24/08/17.
//

import UIKit

public protocol EPCSpinnerViewProtocol {

  var iconSpinner: EPCDrawnIconSpinner { get }

  var state: EPCSpinnerView.SpinnerState { get set }

  func addIcon(_ view: UIView)

  func startAnimating()
}

public class EPCSpinnerView: UIView, EPCSpinnerViewProtocol {

  public enum SpinnerState: Int {
    case loading
    case error
    case success
  }

  public let iconSpinner: EPCDrawnIconSpinner

  required public init?(coder aDecoder: NSCoder) {
    fatalError("\(#file) \(#function) not implemented")
  }

  override public init(frame: CGRect) {
    var fraBounds = frame
    fraBounds.origin = CGPoint.zero
    iconSpinner = EPCDrawnIconSpinner(frame: fraBounds)
    iconSpinner.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    super.init(frame: frame)
    backgroundColor = UIColor.clear
    clipsToBounds = true
    layer.masksToBounds = true
    contentMode = .redraw

    addSubview(iconSpinner)
  }

  public var state: SpinnerState = .loading {
    didSet {
      switch state {
      case .error:
        iconSpinner.setError()
      case .loading:
        iconSpinner.state = .loading
        iconSpinner.start()
      case .success:
        iconSpinner.setCompleted()
      }
    }
  }

  public func addIcon(_ view: UIView) {
    view.center = CGPoint(
      x: CGFloat(Int(self.frame.size.width/2)),
      y: CGFloat(Int(self.frame.size.height/2))
    )
    view.autoresizingMask = [
      .flexibleTopMargin,
      .flexibleRightMargin,
      .flexibleLeftMargin,
      .flexibleBottomMargin,
      .flexibleWidth,
      .flexibleHeight
    ]
    insertSubview(view, at: 0)
  }

  fileprivate func prop(_ val: CGFloat) -> CGFloat {
    return (frame.size.height * val)/180
  }

  // MARK: - Public

  public func startAnimating() {
    iconSpinner.start()
  }
}
