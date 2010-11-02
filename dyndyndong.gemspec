require File.realpath(File.join(File.dirname(__FILE__), 'lib', 'dyndyndong', 'version.rb'))

Gem::Specification.new {|g|
  g.name          = 'dyndyndong'
  g.version       = DynDynDong::VERSION
  g.author        = 'shura'
  g.email         = 'shura1991@gmail.com'
  g.homepage      = 'http://github.com/shurizzle/DynDynDong'
  g.platform      = Gem::Platform::RUBY
  g.description   = 'Ruby written dyndns client.'
  g.summary       = 'Ruby written client to update dynamic dns, it supports many services.'
  g.files         = Dir[ 'lib/**/*.rb' ]
  g.require_path  = 'lib'
  g.executables   = [ 'dyndyndong' ]

  g.has_rdoc      = true

  g.add_dependency('daemons')
  g.add_dependency('net/http')
}
