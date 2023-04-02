# lib/chatgpt_code_review/utilities.rb
require 'rouge'

module ChatGPTCodeReview
  module Utilities
    def highlight_ruby_code(code)
      formatter = Rouge::Formatters::HTML.new
      lexer = Rouge::Lexers::Ruby.new
      formatter.format(lexer.lex(code))
    end
  end
end
