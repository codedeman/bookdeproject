# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'
project 'Bookde.xcodeproj'


def shared_pods
    pod 'Firebase/Core'
    pod 'Firebase/Auth'
    pod 'Firebase/Database'
    pod 'Firebase/Firestore'
    pod 'Firebase/Storage'
    pod 'Firebase/Functions'
    pod 'IQKeyboardManagerSwift', '6.2.1'
    pod 'Kingfisher', '~> 4.0'

end

target 'Bookde' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Bookde
  shared_pods
  pod 'Stripe', '15.0.1'
  pod 'Alamofire'

end

target 'BookdeAdmin' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for BookdeAdmin

    shared_pods
end
