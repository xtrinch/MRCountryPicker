#
# Be sure to run `pod lib lint MRCountryPicker' to ensure this is a
# valid spec before submitting.

Pod::Spec.new do |s|
s.name             = 'MRCountryPicker'
s.version          = '0.0.1'
s.summary          = 'Country picker with flags and optional phone numbers for iOS written in Swift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
Country picker with flags and optional phone numbers for iOS written in Swift. Has the option to set initial country, delegate functions return country code, country name, country phone prefix and country flag.
DESC

s.homepage         = 'https://github.com/xtrinch/MRCountryPicker'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Mojca Rojko' => 'mojca.rojko@gmail.com' }
s.source           = { :git => 'https://github.com/xtrinch/MRCountryPicker', :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

s.ios.deployment_target = '8.0'

s.source_files = 'MRCountryPicker/Classes/**/*'

s.resource_bundles = {
'SwiftCountryPicker' => ['MRCountryPicker/Assets/SwiftCountryPicker.bundle/*']
}

# s.public_header_files = 'Pod/Classes/**/*.h'
# s.frameworks = 'CoreTelephony'
# s.dependency 'AFNetworking', '~> 2.3'
end
