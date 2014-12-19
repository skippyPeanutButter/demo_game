Gem::Specification.new do |s|
  s.name         = "demo_game"
  s.version      = "1.0.0"
  s.author       = "Luis Ortiz"
  s.email        = "lortiz1145@gmail.com"
  s.homepage     = "https://github.com/skippyPeanutButter/demo_game.git"
  s.summary      = "Text based game created following tutorial"
  s.description  = File.read(File.join(File.dirname(__FILE__), 'README'))
  s.licenses     = ['MIT']

  s.files         = Dir["{bin,lib,spec}/**/*"] + %w(LICENSE README)
  s.test_files    = Dir["spec/**/*"]
  s.executables   = [ 'demo_game' ]

  s.required_ruby_version = '>=1.9'
  s.add_development_dependency 'rspec'
end