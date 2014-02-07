$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'bpm_sales/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'bpm_sales'
  s.version     = '0.0.1'
  s.authors     = ['Samuel Shen']
  s.email       = ['samuel@asental.com']
  s.homepage    = 'http://asental.com'
  s.summary     = 'BPM sales engine'
  s.description = 'The gem requires database of customer, quotation, invoice, sales'

  s.files = Dir['{app,config,db,lib}/**/*', 'Rakefile']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '~> 4.0.2'
  s.add_dependency 'sass-rails', '~> 4.0.0'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'bootstrap-sass', '~> 3.1.0'
  s.add_dependency 'will_paginate'
  s.add_dependency 'bootstrap-will_paginate'
  s.add_dependency 'nilify_blanks'
  s.add_dependency 'devise'
  s.add_dependency 'authority'
  #s.add_dependency 'state_machine'
  #s.add_dependency 'ruby-graphviz', :require => 'graphviz' # Optional: only required for graphing
  #s.add_dependency 'wkhtmltopdf-binary'
  #s.add_dependency 'wicked_pdf'
  #s.add_dependency 'whenever'
  s.add_dependency 'payday'

  s.add_development_dependency 'sqlite3'

end
