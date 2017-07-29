class AmericanDate
  def self.parse(str)
    Date.strptime(str, '%m/%d/%Y')
  rescue ArgumentError, TypeError
    nil
  end
end
