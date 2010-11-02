require 'dyndyndong/services'
require 'dyndyndong/dyndyndong'

module DynDynDong

class Client
  def self.start
    DynDynDong::Service.each {|s|
      s.fetch
    }
  end
end

end
