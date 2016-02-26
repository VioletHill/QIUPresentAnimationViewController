#
#  Be sure to run `pod spec lint QIUPresentAnimationViewController.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "QIUPresentKit"
  s.version      = "0.0.3"
  s.summary      = "Launch animation like Twitter"
                   
  s.homepage     = "https://github.com/VioletHill/QIUPresentAnimationViewController"
  s.license      = 'MIT'  
  s.author       = { "QiuFeng" => "qfviolethill@163.com" }
  s.source       = { :git => "https://github.com/VioletHill/QIUPresentAnimationViewController.git", :tag => "0.0.3" }
  s.source_files = 'UIPresentationControllerDemo／src/*.{h,m}'
  s.framework  = 'UIKit', 'Foundation'
  s.platform     = :ios, '8.0'
  s.requires_arc = true  


end
