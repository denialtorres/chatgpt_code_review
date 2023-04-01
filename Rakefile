require 'chatgpt_code_review/reviewer'
require 'pry'

namespace :code_review do
  desc 'Review a commit using ChatGPT'
  task :review, [:github_token, :openai_api_key, :repo, :commit_sha] do |_t, args|
    github_token = args.github_token || ENV['GITHUB_TOKEN']
    openai_api_key = args.openai_api_key || ENV['OPENAI_API_KEY']
    repo = args.repo
    commit_sha = args.commit_sha

    reviewer = ChatGPTCodeReview::Reviewer.new(github_token, openai_api_key)
    reviewer.review(repo, commit_sha)
  end
end

task default: 'code_review:review'
