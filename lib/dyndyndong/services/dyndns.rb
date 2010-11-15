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

class DynDNS < Generic
  set :MSGTABLE, {
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
  set :OFFLINE, 'YES', 'NOCHG'
  set :UPDATE_HOST, 'members.dyndns.org'
end

end
