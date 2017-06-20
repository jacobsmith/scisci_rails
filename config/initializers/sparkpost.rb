module SparkPostRails
  def self.configuration
    @configuration ||= SparkPostRails::Configuration.new
  end
end
