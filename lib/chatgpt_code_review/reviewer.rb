require 'octokit'
require_relative 'api_client'

module ChatGPTCodeReview
  class Reviewer
    def initialize(github_token, openai_api_key)
      @github = Octokit::Client.new(access_token: github_token)
      @api_client = APIClient.new(openai_api_key)
    end

    def review(repository, commit_sha)
      commit = @github.commit(repository, commit_sha)
      files = commit[:files].map { |file| file[:filename] }.join("\n")

      prompt = "Please review the following code changes for the commit #{commit_sha} in the repository #{repository}:\n\n#{files}\n\n"

      response = @api_client.generate_code_review(prompt)
      puts response
    end
  end
end
