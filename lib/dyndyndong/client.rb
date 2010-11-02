require 'dyndyndong/services'
require 'dyndyndong/dyndyndong'

module DynDynDong

class Client
  def self.start
    DynDynDong::Service.each {|s|
      s.fetch
    }
  end

  def self.start_loop
    while true
      self.start
      sleep DynDynDong.delay
    end
  end
end

end
