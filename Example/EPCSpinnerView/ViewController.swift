//
//  ViewController.swift
//  EPCSpinnerView
//
//  Created by evertoncunha on 09/13/2017.
//  Copyright (c) 2017 evertoncunha. All rights reserved.
//

import UIKit
import EPCSpinnerView

class ViewController: UIViewController {
  
  let spinner = EPCSpinnerView()
  
  let buildWithAutolayout = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    if buildWithAutolayout {
      buildViewWithAutolayout()
    }
    else {
      spinner.frame = CGRect(x: 30, y: 30, width: 180, height: 180)
      view.addSubview(spinner)
    }
    
    var fra = CGRect.zero
    fra.size = EPCDrawnIconLock.suggestedSize
    let icon = EPCDrawnIconLock(frame: fra)
    spinner.addIcon(icon)
    
    spinner.startAnimating()
  }
  
  func buildViewWithAutolayout() {
    
    spinner.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(spinner)
    
    let views = ["s":spinner]
    
    NSLayoutConstraint.activate([
      NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[s(180)]", options: [], metrics: nil, views: views),
      NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[s(180)]", options: [], metrics: nil, views: views)
      ].flatMap {return $0})
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  @IBAction func tappedError() {
    spinner.state = .error
  }
  
  @IBAction func tappedSuccess() {
    spinner.state = .success
  }
  
  @IBAction func tappedLoading() {
    spinner.state = .loading
  }
  
  @IBAction func tappedStepper(_ stepper: UIStepper) {
    let val: CGFloat = 180 + CGFloat(stepper.value)
    var fra = spinner.frame
    fra.size = CGSize(width: val, height: val)
    
    UIView.beginAnimations(nil, context: nil)
    UIView.setAnimationDuration(3)
    spinner.frame = fra
    UIView.commitAnimations()
  }
}

