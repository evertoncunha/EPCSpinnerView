//
//  DrawnIconProtocol.swift
//
//  Created by Everton Cunha on 13/09/17.
//

import Foundation

public protocol EPCDrawnIconProtocol {
  func animate()
  static var suggestedSize: CGSize { get }
  var color: UIColor { get set }
}

public extension EPCDrawnIconProtocol where Self: UIView {
  func prop(_ val: CGFloat) -> CGFloat {
    return (frame.size.height * val)/Self.suggestedSize.height
  }
}
