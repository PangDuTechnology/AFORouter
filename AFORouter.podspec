Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.name         = "AFORouter"
  s.version      = "0.0.6"
  s.summary      = "The router."
  s.description  = 'Used to pass values between pages.'
  s.homepage     = "https://github.com/PangDuTechnology/AFORouter.git"

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.license      = "MIT"
  
  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.author             = { "PangDu" => "xian312117@gmail.com" }
  
  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.platform     = :ios, "8.0"
  s.ios.deployment_target = '8.0'

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source       = { :git => "https://github.com/PangDuTechnology/AFORouter.git", :tag => s.version.to_s }

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source_files = 'AFORouter/AFORouter.h'
  s.public_header_files = 'AFORouter/AFORouter.h'   

  s.subspec 'router' do |jl|
      jl.source_files = 'AFORouter/router/*.{h,m}' 
      jl.public_header_files = 'AFORouter/router/*.h' 
  end

  s.subspec 'manager' do |ma|
      ma.dependency 'AFORouter/router'
      ma.dependency 'AFOFoundation'
      ma.source_files = 'AFORouter/manager/*.{h,m}' 
      ma.public_header_files = 'AFORouter/manager/*.h'
  end

  s.subspec 'plist' do |plist|
      plist.dependency 'AFOFoundation'
      plist.source_files = 'AFORouter/plist/*.{h,m}' 
      plist.public_header_files = 'AFORouter/plist/*.h'
  end

  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.requires_arc = true
  s.xcconfig = { 
                  'HEADER_SEARCH_PATHS'=> '"$(SDKROOT)/AFORouter/router/*.h","$(SDKROOT)/AFORouter/manager/*.h"'
                }
end
