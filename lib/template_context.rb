require_relative 'utilities'

module ChatGPTCodeReview
  class TemplateContext
    include Utilities

    attr_reader :method_data

    def initialize(method_data)
      @method_data = method_data
    end

    def context_binding
      binding
    end
  end
end
