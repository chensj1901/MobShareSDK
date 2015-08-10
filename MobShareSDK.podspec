Pod::Spec.new do |s|
    s.name                = "MobShareSDK"
    s.version             = "2.11.1-2"
    s.summary             = 'ShareSDK of mob for iOS.'
    s.license             = 'Copyright © 2012-2015 mob'
    s.author              = { "shingwasix" => "https://github.com/shingwasix" }
    s.homepage            = 'http://mob.com'
    s.source              = { :git => "https://github.com/shingwasix/MobShareSDK.git", :tag => s.version.to_s }
    s.platform            = :ios, '5.1.1'
    s.frameworks          = 'SystemConfiguration', 'QuartzCore', 'CoreTelephony', 'Security', 'JavaScriptCore'
    s.libraries           = 'icucore', 'z.1.2.5', 'stdc++'
    s.default_subspecs    = 'Core'
    s.vendored_frameworks = 'ShareSDK/ShareSDK.framework'
    
    # 核心模块
    s.subspec 'Core' do |sp|
        sp.vendored_frameworks = 'ShareSDK/Core/AGCommon.framework', 'ShareSDK/Core/MOBFoundation.framework', 'ShareSDK/Core/ShareSDKCoreService.framework'
        sp.libraries = 'z', 'icucore'
        sp.resources = ['ShareSDK/Core/Resource.bundle', 'ShareSDK/Core/zh-Hans.lproj/ShareSDKLocalizable.strings']
    end
    
    
    # 拓展（仅内部引用）
    s.subspec 'Extend' do |sp|

        
        # QQConnectSDK
        sp.subspec 'QQConnectSDK' do |ssp|
            ssp.vendored_frameworks = 'ShareSDK/Extend/QQConnectSDK/TencentOpenAPI.framework'
            ssp.resource = 'ShareSDK/Extend/QQConnectSDK/TencentOpenApi_IOS_Bundle.bundle'
            ssp.libraries = 'stdc++', 'sqlite3'
        end
        
        
        # WeChatSDK
        sp.subspec 'WeChatSDK' do |ssp|
            ssp.vendored_libraries = "ShareSDK/Extend/WeChatSDK/*.a"
            ssp.source_files = "ShareSDK/Extend/WeChatSDK/*.{h,m}"
            ssp.public_header_files = "ShareSDK/Extend/WeChatSDK/*.h"
        end
        
    end
    
    # 分享和登陆平台
    s.subspec 'Connection' do |sp|
        sp.default_subspecs =  'WeChat', 'QQ', 'QZone'
        
       
        # 微信
        sp.subspec 'WeChat' do |ssp|
            ssp.dependency 'MobShareSDK/Extend/WeChatSDK'
            ssp.vendored_frameworks = 'ShareSDK/Connection/WeChatConnection.framework'
        end
        
        # 腾讯QQ
        sp.subspec 'QQ' do |ssp|
            ssp.dependency 'MobShareSDK/Extend/QQConnectSDK'
            ssp.vendored_frameworks = 'ShareSDK/Connection/QQConnection.framework'
        end
        
        # QQ空间
        sp.subspec 'QZone' do |ssp|
            ssp.dependency 'MobShareSDK/Extend/QQConnectSDK'
            ssp.vendored_frameworks = 'ShareSDK/Connection/QZoneConnection.framework'
        end
    end
end
