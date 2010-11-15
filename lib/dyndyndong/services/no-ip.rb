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

class NoIp < DynDNS
  set :MSGTABLE, {
      'good'      => 'DNS hostname update successful.',
      'nochg'     => 'IP address is current, no update performed.',
      'nohost'    => 'Hostname supplied does not exist under specified account.',
      'badauth'   => 'Invalid username password combination.',
      'badagent'  => 'Client disabled.',
      '!donator'  => 'An update request was sent including a feature that is not available to that particular user such as offline options.',
      'abuse'     => 'Username is blocked due to abuse.',
      '911'       => 'A fatal error on our side such as a database outage.'
    }
  set :UPDATE_HOST, 'dynupdate.no-ip.com'
end

end
