Pod::Spec.new do |s|
    s.name         = "Medea"
    s.version      = "0.0.13"
    s.summary      = "Strict but helpful JSON library for Swift"
    s.description  = <<-DESC
                        This library combines some new handy features to manipulate JSON together with best ideas from other libraries.
                        Inspired by SwiftyJSON, Gloss and TidyJSON.
                     DESC
    s.homepage     = "https://github.com/SwiftMedea/Medea"
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.author       = { "Anton Bronnikov" => "anton.bronnikov@gmail.com" }

    s.ios.deployment_target     = "8.0"
    s.osx.deployment_target     = "10.9"
    s.watchos.deployment_target = "2.0"
    s.tvos.deployment_target    = "9.0"

    s.source       = { :git => "https://github.com/SwiftMedea/Medea.git", :tag => "#{s.version}" }
    s.source_files = "Sources/**/*.{swift,h}"
end
