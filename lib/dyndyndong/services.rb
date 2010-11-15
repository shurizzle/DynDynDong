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

$DEBUG = true

module DynDynDong

class Service

  def initialize(&block)
    @@instances ||= []
    @@instances << self
    @hosts = []
    self.instance_eval(&block) if block
  end

  def fetch
    begin
      prefetch if self.respond_to?(:prefetch)
    rescue Exception => e
      STDERR.puts("Prefetch error: #{e}, skipping...")
      return
    end

    @hosts.each {|args|
      STDOUT.write("Aliasing #{args.is_a?(Array) ? args.first : args}...")
      begin
        res = alias_host(*args)
        STDOUT.write("\r--- #{args.is_a?(Array) ? args.first : args}        \n\t#{res.gsub(/\n/, "\n\t")}\n")
      rescue Exception => e
        STDERR.puts("\tFetch error: #{e}, skipping...")
      end
    }

    begin
      postfetch if self.respond_to?(:postfetch)
    rescue Exception => e
      STDERR.puts("Postfetch error: #{e}")
    end
  end

  def method_missing(sym, *args, &block)
    STDERR.puts("#{sym.to_s.inspect} missed for #{self.class}, skipping...")
  end

  def self.instances
    @@instances ||=[]
    @@instances
  end

  def self.inherited(obj)
    @@services ||= []
    @@services << obj
  end

  def self.services
    @@services ||= []
    @@services
  end

  def self.each
    objs = []
    self.instances.each {|i|
      objs << i
      yield i if block_given?
    }
    if block_given?
      objs
    else
      Enumerator.new(objs)
    end
  end

end

end

%w{afraid dyndns zoneedit}.each {|s|
  require "dyndyndong/services/#{s}"
}
