# Uncomment the next line to define a global platform for your project
platform :ios, (ENV['OS_VERSION'] || '12.0')

def shared_pods
  pod 'SwiftLint'
  pod 'SnapKit'
  pod 'CircleProgressView', '~> 1.0'
  pod 'Moya'
  pod 'SwiftyJSON'
end

target 'strolling-of-time-ios' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  shared_pods
  # Pods for strolling-of-time-ios

  target 'strolling-of-time-iosTests' do
    inherit! :search_paths
    # Pods for testing
  end
end

target 'strolling-of-time-iosUITests' do
  # Pods for testing
  shared_pods
end