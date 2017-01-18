Pod::Spec.new do |s|

  s.name                  = 'GradientColorSignal'
  s.version               = '0.0.2'
  s.summary               = 'Animated Gradient Color Signal.'
  s.homepage              = 'https://github.com/Dwarven/GradientColorSignal'
  s.ios.deployment_target = '7.0'
  s.license               = { :type => 'MIT', :file => 'LICENSE' }
  s.author                = { 'Dwarven' => 'prison.yang@gmail.com' }
  s.social_media_url      = "https://twitter.com/DwarvenYang"
  s.source                = { :git => 'https://github.com/Dwarven/GradientColorSignal.git', :tag => s.version }
  s.source_files          = 'Class/*.{h,m}'

end
