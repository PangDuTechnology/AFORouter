Pod::Spec.new do |s|

  s.name         = "AFORouter"
  s.version      = "0.0.15"
  s.summary      = "The router."
  s.description  = <<-DESC
    基于 JLRoutes 的应用内路由与页面跳转封装，依赖 AFOFoundation、AFOSchedulerCore。
  DESC
  s.homepage     = "https://github.com/PangDuTechnology/AFORouter"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "PangDu" => "xian312117@gmail.com" }

  s.platform     = :ios, "13.0"
  s.ios.deployment_target = "13.0"

  # 推送到 GitHub 后，请为每个发布版本打同名 tag（与 s.version 一致），否则无法通过 :git + :tag 安装。
  s.source       = { :git => "https://github.com/PangDuTechnology/AFORouter.git", :tag => s.version.to_s }

  s.requires_arc = true
  s.frameworks   = "Foundation", "UIKit"

  s.source_files = "AFORouter/AFORouter.h", "AFORouter/AFORouting.{h,m}"
  s.public_header_files = "AFORouter/AFORouter.h", "AFORouter/AFORouting.h"
  s.default_subspecs = "router", "manager"

  s.dependency "AFOSchedulerCore"

  s.subspec "router" do |jl|
    jl.source_files = "AFORouter/router/*.{h,m}"
    jl.public_header_files = "AFORouter/router/*.h"
  end

  s.subspec "manager" do |ma|
    ma.dependency "AFORouter/router"
    ma.dependency "AFOFoundation"
    ma.source_files = "AFORouter/manager/*.{h,m}"
    ma.public_header_files = "AFORouter/manager/*.h"
  end
end
