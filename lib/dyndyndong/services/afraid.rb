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
# along with failirc. If not, see <http://www.gnu.org/licenses/>.

require 'net/http'

module DynDynDong

class Afraid < Service
  def initialize(*args)
    super(*args)
  end

  def host(domain, hash)
    @hosts << [domain, hash]
  end

  def alias_host(domain, hash)
    begin
      res = Net::HTTP.get(URI.parse("http://freedns.afraid.org/dynamic/update.php?#{hash}"))
    rescue Exception => e
      return "#{e} -- skipping..."
    end
    res
  end
end

end
