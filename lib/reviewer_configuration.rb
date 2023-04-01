# lib/flog_configuration.rb
class ReviewerConfiguration
  attr_accessor :threshold, :dirs, :chatgpt

  def initialize
    @threshold = 30
    @dirs = %w(app lib)
    @chatgpt = ""
  end
end
