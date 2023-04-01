# lib/reviewer_configurable.rb
require_relative 'reviewer_configuration'

module ReviewerConfigurable
  def self.configuration
    @configuration ||= ReviewerConfiguration.new
  end

  def self.configure
    yield(configuration)
  end
end
