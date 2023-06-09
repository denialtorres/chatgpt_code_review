# frozen_string_literal: true

require_relative "lib/chatgpt_code_review/version"

Gem::Specification.new do |spec|
  spec.name = "chatgpt_code_review"
  spec.version = ChatgptCodeReview::VERSION
  spec.authors = ["Daniel Torres"]
  spec.email = ["denial.torres@gmail.com"]

  spec.summary = "Gem for code reviews"
  spec.description = "Gem for code reviews"
  spec.homepage = "https://www.apptegy.com"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://example.com"

  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.files.reject! { |file| file.include?('pkg') || file.end_with?('.gem') }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'http', '>= 4.0.0' # For making HTTP requests to OpenAI API
  spec.add_dependency 'octokit', '~> 4.0' # For interacting with GitHub API
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_dependency 'flog', '~> 4.6'
  spec.add_dependency 'method_source', '>= 0.9.2'
  spec.add_dependency 'rainbow', '~> 3.0'
  spec.add_dependency 'activesupport', '>= 5.0'
  spec.add_dependency 'actionview', '>= 5.0'
  spec.add_dependency 'rouge', '>= 3.0'
  spec.add_dependency 'ruby-openai'


  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
