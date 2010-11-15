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

module DynDynDong

class ZoneEdit < Service
  def initialize(*args)
    @user = nil
    @pass = nil
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
    @hosts << h.to_s
  end

  def prefetch
    if !(@user and @pass)
      raise "username or password ungiven"
    end
  end

  def alias_host(h)
    Net::HTTP.start('dynamic.zoneedit.com') {|http|
      req = Net::HTTP::Get.new('/auth/dynamic.html?host=%s' % [URI.escape(h)])
      req.basic_auth @user, @pass
      http.request(req)
      "DONE"
    }
  end
end

end
