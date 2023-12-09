#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint insta_login.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'insta_login'
  s.version          = '0.0.2'
  s.summary          = 'This package is intended to let developers easily integrate instagram integration in Flutter Application. We will be using Instagram Basic Display API.'
  s.description      = <<-DESC
  This package is intended to let developers easily integrate instagram integration in Flutter Application. We will be using Instagram Basic Display API.
                       DESC
  s.homepage         = 'https://github.com/AyeshaIftikhar/insta_login.git'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'ByteBrad Systems' => 'seayeshaiftikhar@gmail.com' }

  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'FlutterMacOS'

  s.platform = :osx, '10.11'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
