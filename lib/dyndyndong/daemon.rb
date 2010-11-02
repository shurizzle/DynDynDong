require 'dyndyndong/client'
require 'daemons'

module DynDynDong

class Daemon
  def self.start
    Daemons.daemonize

    while true
      DynDynDong::Client.start
      sleep DynDynDong.delay
    end
  end
end

end
