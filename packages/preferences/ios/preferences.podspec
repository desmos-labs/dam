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
  s.source_files = 'Classes/**/*'
  s.static_framework = true
  s.vendored_libraries = "libcrw_preferences.a"
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
