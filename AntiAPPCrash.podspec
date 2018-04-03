#
# Be sure to run `pod lib lint AntiAPPCrash.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AntiAPPCrash'
  s.version          = '0.0.5'
  s.summary          = 'AntiAPPCrash. 防止APP常见的崩溃问题'

  s.description      = <<-DESC
  AntiAPPCrash. 防止APP常见的崩溃问题，防患于未然
                       DESC

  s.homepage     = 'https://www.51songguo.com/'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tangbl93' => 'tangbl93@gmail.com' }
  s.source           = { :git => 'https://gitee.com/gongguo/AntiAPPCrash.git', :tag => s.version.to_s }

  # support for iOS 8
  s.ios.deployment_target = '8.0'

  s.source_files = 'AntiAPPCrash/**/*.{h,m}'
  s.public_header_files = 'AntiAPPCrash/**/*.{h}'

  s.requires_arc = true

end
