require 'chatgpt_code_review/version'
require 'flog_cli'
require 'flog'
require 'method_source'
require 'rainbow'
require 'erb'
require 'pry'
require 'active_support'
require 'action_view'
require 'reviewer_configurable'


def generate_html_report(method_data)
  erb_template = File.read(File.expand_path('../templates/report.erb', __FILE__))
  renderer = ERB.new(erb_template)
  output = renderer.result(binding)

  # Save the HTML report to a file
  report_path = File.join(Dir.pwd, 'public', 'flog_report.html')
  File.write(report_path, output)

  puts Rainbow("HTML report generated at: #{report_path}").blue.bold
end

def prompt(code)
  <<-HEREDOC
    I want you to act as a ruby console.
    I will type commands and you will reply with what the ruby console should show.
    I want you to only reply with the terminal output inside one unique code block, and nothing else.
    do not write explanations.
    when I need to tell you something in english,
    I will do so by putting text inside curly brackets {like this}.

  { how to refactor the next method using simple code instead of smart code,
    you can rename the variables to improve readability,
    include comments that explain what the method or the class or one line is doing}

    ```
    #{code}
    ```
  HEREDOC
end

def get_suggestion(code)
  token = ReviewerConfigurable.configuration.chatgpt

  client = OpenAI::Client.new(access_token: token)

  prompt_text = prompt(code)

  message = [{ role: "user", content: prompt_text}]

  @client = OpenAI::Client.new(access_token: token)

  response = @client.chat(
      parameters: {
          model: "gpt-3.5-turbo",
          messages: message,
          temperature: 0.7
      })

  return response.dig("choices").first.dig("message", "content")
end

module FlogReporter
  class Error < StandardError; end

  def self.generate_report
    threshold = ReviewerConfigurable.configuration.threshold
    dirs = ReviewerConfigurable.configuration.dirs

    expander = PathExpander.new dirs, "**/*.{rb,rake}"
    flog = Flog.new :continue => true, :quiet => true, :methods => true
    files = expander.process
    method = :total_score
    flog.flog(*files)

    results = flog.totals.select { |_, score| score > threshold }
    method_data = []


    if results.empty?
      puts "No methods found with a complexity score over #{threshold}."
    else
      puts "Methods with a complexity score over #{threshold}:"
      results.each do |method, score|
         puts "  #{method}: #{score.round(2)}"
         class_name, method_name = method.split('#')

         begin
           klass = class_name.constantize
           method_obj = klass.instance_method(method_name)
           klass = class_name.constantize
           method_obj = klass.instance_method(method_name)
           method_details = {
              class: klass,
              method: method_name,
              path: method_obj.source_location[0],
              code: method_obj.source.strip,
              suggestion: ""
            }

            method_details[:sugestion] = get_suggestion(method_details[:code])

            method_data << method_details
           puts "  Method Source:\n\n  #{method_obj.source.strip}\n\n"
         rescue NameError => e
           puts "  Unable to find source for method: #{e.message}"
         end
       end
    end

    # Generate the HTML report
    generate_html_report(method_data)
  end
end
