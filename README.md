# ChatgptCodeReview

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/chatgpt_code_review`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'chatgpt_code_review'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install chatgpt_code_review

## Usage

Include a new initializer `config/initializers/reviewer.rb`
the next configuration
```ruby
# config/initializers/reviewer_configurable.rb
require 'reviewer_configurable'

ReviewerConfigurable.configure do |config|
  # the desired complexity score
  config.threshold = 30
  # the directories you want to be scanned
  config.dirs = %w(app lib)
  # your ChatGPT key
  config.chatgpt ="sk-*****"
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/chatgpt_code_review.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
