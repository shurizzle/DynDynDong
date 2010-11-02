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
      prefetch if (self.method(:prefetch) rescue nil)
    rescue Exception => e
      STDERR.puts("Prefetch error: #{e}, skipping...")
      return
    end

    @hosts.each {|args|
      STDOUT.write("Aliasing #{args.first}...")
      begin
        res = alias_host(*args)
        STDOUT.write("\r--- #{args.first}        \n\t#{res.gsub(/\n/, "\n\t")}\n")
      rescue Exception => e
        STDERR.puts("\tFetch error: #{e}, skipping...")
      end
    }

    begin
      postfetch if self.method(:postfetch) rescue nil
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

require 'dyndyndong/services/afraid'
require 'dyndyndong/services/dyndns'
