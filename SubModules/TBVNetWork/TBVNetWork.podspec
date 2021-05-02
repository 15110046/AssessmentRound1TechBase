#
# Be sure to run `pod lib lint TBVNetWork.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TBVNetWork'
  s.version          = '0.1.1'
  s.summary          = 'A short description of TBVNetWork.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/15110046a@gmail.com/TBVNetWork'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '15110046a@gmail.com' => 'hieunguyenute@gmail.com' }
  s.source           = { :git => 'https://github.com/15110046a@gmail.com/TBVNetWork.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.swift_version = '4.2'
  s.static_framework = true

  s.source_files = 'TBVNetWork/Classes/**/*.{h,m,swift}'
  s.platforms = {
      "ios": "10.0"
  }
  s.dependency 'Alamofire', '4.9.0'
  s.dependency 'Alamofire-SwiftyJSON', '3.0.0'

end
