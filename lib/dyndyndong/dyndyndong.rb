module DynDynDong
  def self.delay
    @delay || 600
  end

  def self.delay=(n)
    raise Exception, "Insert a numeric value for delay" if !n.is_a?(Numeric)
    @delay = n
  end
end
