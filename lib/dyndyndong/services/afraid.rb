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
