class String
  def identify
    if Mongoid.parameterize_keys
      downcase.gsub(/[^a-z0-9]+/, ' ').strip.gsub(' ', '-')
    else
      self
    end
  end
end
