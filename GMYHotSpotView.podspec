Pod::Spec.new do |s|

  s.name         = "GMYHotSpotView"
  s.version      = "1.0.0.0"
  s.summary      = "A Simple HotSpotView."

  s.description  = <<-DESC
                   a simple HotspotView support Layout By yourSelf
                   DESC

  s.homepage     = "https://github.com/778477/GMYHotSpotView"
  s.author             = { "778477" => "1032419360@qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "git@github.com:778477/GMYHotSpotView.git", :tag => "1.0.0.0" }


  s.source_files  = "GMYHotSpotView/GMYHotSpotView.{h,m}", "GMYHotSpotView/Category/*.{h,m}", "GMYHotSpotView/Model/*.{h,m}" "GMYHotSpotView/Layout/*.{h,m}"
  
  s.requires_arc = true
end
