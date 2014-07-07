class Hash
  def map_values
    h = {}
    self.each do |k,v|
      h[k] = yield(v)
    end
    h
  end
end
