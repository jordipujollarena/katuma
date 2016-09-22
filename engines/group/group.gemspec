$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'group/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'group'
  s.version     = Group::VERSION
  s.authors     = ['katuma team']
  s.email       = ['info@katuma.org']
  s.homepage    = 'http://www.katuma.org'
  s.summary     = 'Groups engine.'
  s.description = 'Groups management engine.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.test_files = Dir['spec/**/*']

  s.add_dependency 'rails', '4.2.5'
  s.add_dependency 'pg', '0.18.3'

  s.add_development_dependency 'rspec-rails', '3.5.0'
  s.add_development_dependency 'byebug', '9.0.5'
  s.add_development_dependency 'rspec-its', '1.2.0'
  s.add_development_dependency 'shoulda-matchers', '3.0.1'
  s.add_development_dependency 'factory_girl_rails', '4.5.0'
end
