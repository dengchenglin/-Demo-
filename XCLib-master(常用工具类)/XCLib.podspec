Pod::Spec.new do |s|
  s.name         = "XCLib"
  s.version      = "0.0.1"
  s.summary      = "整理的iOS开发常用的工具库，包含加解密、网络请求，文件读写，本地缓存等"
  s.homepage     = "https://github.com/sinsmin"
  s.license      = "MIT (LICENSE)"
  s.author       = { "sinsmin" => "sinsmin@qq.com" }
  s.source       = { :git => "https://github.com/sinsmin/XCLib.git", :tag => s.version.to_s }
  s.platform     = :ios, "7.0"
  s.requires_arc = true
  s.source_files = "XCLib", "XCLib/XCLib/*.{h,m}"
  s.framework    = "Foundation","CoreGraphics","UIKit","Security"
end
