Pod::Spec.new do |s|
s.name                  = 'SEKNavigationView'
s.version      = '0.0.1'
s.summary               = 'SEKNavigationView is a easy to develop iOS'
s.homepage              = 'https://github.com/lovemo/SEKNavigationView'
s.platform     = :ios, '8.0'
s.license               = 'MIT'
s.author                = { 'lovemo' => 'lovemomoyulin@qq.com' }
s.source                = { :git => 'https://github.com/lovemo/SEKNavigationView.git',:tag => s.version.to_s }
s.source_files     = 'SEKNavigationView/**/*'
s.requires_arc          = true
s.frameworks             = 'Foundation', 'UIKit'

end