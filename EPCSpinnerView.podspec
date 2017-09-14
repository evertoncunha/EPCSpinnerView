#
# Be sure to run `pod lib lint EPCSpinnerView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'EPCSpinnerView'
  s.version          = '0.1.0'
  s.summary          = 'A simple spinner view that animates to error or success states.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A simple spinner view that animates to error or success states.
                       DESC

  s.homepage         = 'https://github.com/evertoncunha/EPCSpinnerView'
  # s.screenshots     = 'https://github.com/evertoncunha/EPCSpinnerView/blob/master/Example.gif?raw=true'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'evertoncunha' => 'ever.cunha@gmail.com' }
  s.source           = { :git => 'https://github.com/evertoncunha/EPCSpinnerView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/evertoncunha'

  s.ios.deployment_target = '8.0'

  s.source_files = 'EPCSpinnerView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'EPCSpinnerView' => ['EPCSpinnerView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
