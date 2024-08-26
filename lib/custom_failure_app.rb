# lib/custom_failure_app.rb

class CustomFailureApp < Devise::FailureApp
  def respond
    request.format.json? ? api_response : super
  end

  private
  def api_response
    self.status = 401
    self.content_type = 'application/json'
    # optional - send a message in the response body
    # response.body = { error: i18n_message }.to_json
  end
end
