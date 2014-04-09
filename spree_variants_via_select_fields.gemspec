# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_variants_via_select_fields'
  s.version     = '2.1.0'
  s.summary     = 'Add gem summary here'
  s.description = 'Add (optional) gem description here'
  s.required_ruby_version = '>= 1.9.3'

  s.author            = 'Gordon Friebe'
  # s.email             = 'david@loudthinking.com'
  # s.homepage          = 'http://www.rubyonrails.org'
  # s.rubyforge_project = 'actionmailer'

  #s.files         = `git ls-files`.split("\n")
  #s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '>= 2.0'
  s.add_development_dependency 'rspec-rails'
end

