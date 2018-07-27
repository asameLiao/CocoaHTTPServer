Pod::Spec.new do |s|

  s.name         = "CocoaHTTPServer"
  s.version      = "2.3"
  s.summary      = "A small, lightweight, embeddable HTTP server for Mac OS X or iOS applications."
  s.homepage     = "https://github.com/robbiehanson/CocoaHTTPServer"
  s.license      = { :type => 'Apache License, Version 2.0', :file => 'LICENSE' }
  s.author       = { "Robbie Hanson" => "cocoahttpserver@googlegroups.com" }

  # for using GCD queue as Objective-C objects
  s.ios.deployment_target = "6.0"
  s.source       = { :git => "https://github.com/robbiehanson/CocoaHTTPServer.git", :tag => "#{s.version}" }

  s.source_files  = '{Core,Extensions}/**/*.{h,m}'
  s.public_header_files = 'MQTTKit/MQTTKit.h'
  s.frameworks = "CFNetwork","Security"
  s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2"}
  s.dependency 'CocoaLumberjack','CocoaAsyncSocket'
  s.requires_arc = true

end
