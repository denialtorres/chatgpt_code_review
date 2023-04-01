# frozen_string_literal: true
require 'pry'
require_relative "chatgpt_code_review/version"

require 'chatgpt_code_review/railtie' if defined?(Rails)


module ChatgptCodeReview
  class Error < StandardError; end
  # Your code goes here...
end
