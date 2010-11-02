require 'net/http'

module DynDynDong

class DynDNS < Service
  MSGTABLE = {
    'badauth'         => 'The username and password pair do not match a real user.',
    '!donator'        => 'Option available only to credited users.',
    'good'            => 'The update was successful, and the hostname is now updated.',
    'nochg'           => 'The update changed no settings, and is considered abusive.',
    'notfqdn'         => 'The hostname specified is not a fully-qualified domain name.',
    'nohost'          => 'The hostname specified does not exist in this user account.',
    'numhost'         => 'Too many hosts specified in an update.',
    'abuse'           => 'The hostname specified is blocked for update abuse.',
    'badagent'        => 'The user agent was not sent or HTTP method is not permitted.',
    'good 127.0.0.1'  => 'Request was ignored because of agent that does not follow our specifications.',
    'dnserr'          => 'DNS error encountered.',
    '911'             => 'There is a problem or scheduled maintenance on our side.'
  }

  def initialize(*args)
    @user = nil
    @pass = nil
    @ip = getip
    super(*args)
  end

  def username(u)
    @user = u.to_s
  end

  def password(p)
    @pass = p.to_s
  end

  alias username= username
  alias password= password

  def host(h)
    begin
      @hosts << [h.to_s, getip(h)]
    rescue Exception => e
      STDERR.puts "Ip detection error: #{e}, skipping..."
    end
  end

  def offline(h)
    begin
      @hosts << [h.to_s, getip(h), true]
    rescue Exception => e
      STDERR.puts "Ip detection error: #{e}, skipping..."
    end
  end

  def prefetch
    if !(@user and @pass)
      raise "username or password ungiven"
    end
  end

  def alias_host(h, ip, offline = false)
    return "Nothing to update." if ip == @ip

    Net::HTTP.start('members.dyndns.org') {|http|
      req = Net::HTTP::Get.new('/nic/update?hostname=%s&myip=%s&offline=%s' % [
          URI.escape(h), @ip, (offline ? 'YES' : 'NOCHG')])
      req.basic_auth @user, @pass
      x = http.request(req).body.gsub(/#{Regexp.escape(@ip)}/, '').strip
      MSGTABLE[x]
    }
  end

private
  def getip(h = nil)
    if h
      addr = Socket::getaddrinfo(h, 'www', nil, Socket::SOCK_STREAM)[0][3]
      if addr == Socket::getaddrinfo(Socket::gethostname, 'www', nil, Socket::SOCK_STREAM)[0][3]
        return @ip
      else
        return addr
      end
    end
    str = Net::HTTP.get(URI.parse('http://checkip.dyndns.org/')).
      match(/<body>(.+?)<\/body>/)[1] rescue ""
    if str =~ /^Current IP Address: \d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/
      return str.gsub(/^Current IP Address: /, '')
    else
      raise "Couldn't retrieve ip."
    end
  end
end

end
