require './common'

DynDynDong::DynDNS.new {
  username 'user'
  password 'pass'

  host 'my.host.org'
}

DynDynDong::Daemon.start
