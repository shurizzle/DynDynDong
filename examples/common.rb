begin
  require 'dyndyndong'
rescue LoadError
  $LOAD_PATH.unshift File.realpath(File.join(File.dirname(__FILE__), '..', 'lib'))
  retry
end
