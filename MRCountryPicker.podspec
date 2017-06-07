Pod::Spec.new do |s|
s.name             = 'MRCountryPicker'
s.version          = '0.0.7'
s.summary          = 'Country picker with flags and optional phone numbers for iOS written in Swift.'

s.description      = <<-DESC
Country picker with flags and optional phone numbers for iOS written in Swift. Has the option to set initial country, delegate functions return country code, country name, country phone prefix and country flag. Swift 3 support.
DESC

s.homepage         = 'https://github.com/xtrinch/MRCountryPicker'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Mojca Rojko' => 'mojca.rojko@gmail.com' }
s.source           = { :git => 'https://github.com/xtrinch/MRCountryPicker.git', :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

s.ios.deployment_target = '8.0'

s.source_files = 'MRCountryPicker/Classes/**/*'

s.resource_bundles = {
'SwiftCountryPicker' => ['MRCountryPicker/Assets/SwiftCountryPicker.bundle/*']
}

end
