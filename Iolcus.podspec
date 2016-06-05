Pod::Spec.new do |s|
    s.name         = "Iolcus"
    s.version      = "0.0.14"
    s.summary      = "Swift JSON library"
    s.description  = <<-DESC
                        Swift JSON library.
                        Inspired by SwiftyJSON, Gloss and TidyJSON.
                     DESC
    s.homepage     = "https://github.com/iolcus/iolcus"
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.author       = { "Anton Bronnikov" => "anton.bronnikov@gmail.com" }

    s.ios.deployment_target     = "8.0"
    s.osx.deployment_target     = "10.9"
    s.watchos.deployment_target = "2.0"
    s.tvos.deployment_target    = "9.0"

    s.source       = { :git => "https://github.com/iolcus/iolcus.git", :tag => "#{s.version}" }
    s.source_files = "Sources/**/*.{swift,h}"
end
