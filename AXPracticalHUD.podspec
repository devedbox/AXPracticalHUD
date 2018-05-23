#
#  Be sure to run `pod spec lint AXPracticalHUD.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "AXPracticalHUD"
  s.version      = "2.1.3"
  s.summary      = "A practical hud view in iOS."
  s.description  = <<-DESC
                   A practical hud view in iOS.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "https://github.com/devedbox/AXPracticalHUD"
  s.license      = "MIT"
  s.author       = { "devedbox" => "devedbox@qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/devedbox/AXPracticalHUD.git", :tag => s.version }
  s.source_files = "AXPracticalHUD/AXPracticalHUD/*.{h,m}", "AXPracticalHUD/AXPracticalHUD/*/*.{h,m}"
  s.public_header_files = "AXPracticalHUD/AXPracticalHUD/*.{h}", "AXPracticalHUD/AXPracticalHUD/*/*.{h}", "AXPracticalHUD/AXPracticalHUD/ContentView/*.{h}"
  s.resource     = "AXPracticalHUD/AXPracticalHUD/AXPracticalHUD.bundle"
  s.frameworks   = "UIKit", "Foundation"
  s.requires_arc = true
  s.dependency "AXIndicatorView"
end
