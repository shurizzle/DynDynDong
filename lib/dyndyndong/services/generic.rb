#--
# Copyleft shura. [shura1991@gmail.com]
#
# This file is part of DynDynDong.
#
# DynDynDong is free software: you can redistribute it and/or modify 
# it under the terms of the GNU Affero General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# DynDynDong is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with dyndyndong. If not, see <http://www.gnu.org/licenses/>.
#++

require 'net/http'
require 'resolv'

module DynDynDong

class Generic < Service
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
    @hosts << [h.to_s]
  end

  def offline(h)
    @hosts << [h.to_s, true]
  end

  def prefetch
    raise "username or password ungiven" if !(@user and @pass)
    @ip = getip
  end

  def alias_host(h, offline = false)
    Net::HTTP.start(update_host) {|http|
      req = Net::HTTP::Get.new('/nic/update?hostname=%s&myip=%s&offline=%s' % [
          URI.escape(h), getip(h), offline?(offline)])
      req.basic_auth @user, @pass
      x = http.request(req).body.gsub(/#{Regexp.escape(@ip)}/, '').strip
      MSGTABLE(x)
    }
  end

  def self.set(*args)
    sym = args.shift.to_s.downcase
    case sym
    when 'msgtable'
      raise ArgumentError, "wrong number of arguments (#{args.size} for 1)" if args.size != 1
      raise ArgumentError, "wrong type" if !args.first.is_a?(Hash)
      self.class_eval %Q{
        def MSGTABLE(x)
          #{args.first.inspect}[x]
        end
      }
    when 'update_host'
      raise ArgumentError, "wrong number of arguments (#{args.size} for 1)" if args.size != 1
      raise ArgumentError, "wrong type" if !args.first.is_a?(String)
      self.class_eval %Q{
        def update_host
          #{args.first.inspect}
        end
      }
    when 'offline'
      raise ArgumentError, "wrong number of arguments (#{args.size} for 2)" if args.size != 2
      raise ArgumentError, "wrong type" if !args[0].is_a?(String) or !args[1].is_a?(String)
      self.class_eval %Q{
        def offlines(what)
          {
            'YES' => #{args[0].inspect},
            'NO'  => #{args[1].inspect}
          }[what]
        end
      }
    end
  end

private

  def offlines(what)
    {
      'YES' => 'YES',
      'NO'  => 'NO'
    }[what]
  end
  
  def offline?(offline)
    offline ? offlines('YES') : offlines('NO')
  end

  def getip(h = nil)
    if h
      hosts = ""
      Resolv.new.each_address(h) {|ho|
        hosts = ho
      }
      return hosts
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
