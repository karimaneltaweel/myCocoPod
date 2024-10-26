
Pod::Spec.new do |s|
  s.name             = 'MyCocoPod'
  s.version          = '0.1.0'
  s.summary      = "A brief description of MyFramework project."


  #s.description      = 'TODO: Add long description of the pod here.'
  s.homepage         = 'https://github.com/karimaneltaweel/MyCocoPod'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'karimaneltaweel' => 'kariman.hesham@advaeg.com' }
  s.source           = { :git => 'https://github.com/karimaneltaweel/MyCocoPod.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.platform     = :ios, '10.0'
  s.swift_version = '5.0'
  s.source_files = 'MyCocoPod/Classes/**/*'
  
#   s.resource_bundles = {
#     'Resourses' => ['MyCocoPod/Assets/*']
#   }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'Alamofire', '~> 5.0'
  s.dependency 'SwiftyJSON', '~> 5.0'

end
