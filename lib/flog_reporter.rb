require 'chatgpt_code_review/version'
require 'flog_cli'
require 'flog'
require 'method_source'
require 'rainbow'
require 'erb'
require 'pry'
require 'active_support'
require 'action_view'

def generate_html_report(method_data)
  erb_template = File.read(File.expand_path('../templates/report.erb', __FILE__))
  renderer = ERB.new(erb_template)
  output = renderer.result(binding)

  # Save the HTML report to a file
  report_path = File.join(Dir.pwd, 'public', 'flog_report.html')
  File.write(report_path, output)

  puts Rainbow("HTML report generated at: #{report_path}").blue.bold
end


module FlogReporter
  class Error < StandardError; end

  def self.generate_report(threshold: 30, dirs: %w(app lib))
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
              code: method_obj.source.strip
            }
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
