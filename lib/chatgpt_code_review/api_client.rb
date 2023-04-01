require "openai"

module ChatGPTCodeReview
  class APIClient
    def initialize(api_key)
      @api_key = api_key
      @client = OpenAI::Client.new(access_token: api_key)
    end

    def generate_code_review(prompt)
      message = [{ role: "user", content: prompt}]

      response = @client.chat(
          parameters: {
              model: "gpt-3.5-turbo",
              messages: message,
              temperature: 0.7
          })
      response.choices[0].text.strip
    end
  end
end
