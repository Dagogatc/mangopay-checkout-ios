
Pod::Spec.new do |spec|

  spec.name         = "MangopayCheckoutSDK"
  spec.version      = "1.1.4"
  spec.summary      = "Checkout API Client, Payment Form UI and Utilities in Swift."

  spec.description  = <<-DESC
  Checkout API Client and Payment Form Utilities in Swift.
  This library contains methods to implement a payment form as well as UI elements.
                   DESC

  spec.homepage     = "https://www.mangopay.com"
  spec.license      = "MIT"

  spec.author             = { "Elikem Savie" => "elikem@menaget.com" }

  spec.platform     = :ios
  spec.ios.deployment_target = "14.0"
  spec.swift_version = '5.0'


  spec.source       = { :git => "https://github.com/Mangopay/mangopay-checkout-ios.git", :tag => "#{spec.version}", :branch => "main" }

  spec.source_files  = "MangopayCheckoutSDK/**/*.swift"
  spec.dependency     'MangopayVaultSDK', '~> 1.0.8'
  spec.exclude_files = [
  'MangopayCheckoutSDK/Resources/SPMextension.swift',
  'MangopayCheckoutSDK/MangopayPaymentSheet/PaymentFormView.swift'
  ]
  
  spec.resource_bundles = {
    'MangopayiOSSDK_MangopayCheckoutSDK' => ['MangopayCheckoutSDK/**/*.{lproj,png,jpeg,jpg,storyboard,xib,xcassets,json}']
  }
end
