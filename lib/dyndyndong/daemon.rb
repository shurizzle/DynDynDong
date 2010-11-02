require 'dyndyndong/client'
require 'daemons'

module DynDynDong

class Daemon
  def self.start
    Daemons.daemonize

    DynDynDong::Client.start_loop
  end
end

end
