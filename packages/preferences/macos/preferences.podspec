#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint preferences.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'preferences'
  s.version          = '0.0.1'
  s.summary          = 'crw-preferences FFI bindings'
  s.description      = <<-DESC
crw-preferences FFI bindings.
                       DESC
  s.homepage         = 'http://forbole.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Manuel Turetta' => 'manuel@forbole.com' }
  s.source           = { :path => '.' }
  s.public_header_files = 'Classes**/*.h'
  s.source_files     = 'Classes/**/*'
  s.static_framework = true
  s.vendored_libraries = "libcrw_preferences.a"
  s.dependency 'FlutterMacOS'

  s.platform = :osx, '10.11'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
