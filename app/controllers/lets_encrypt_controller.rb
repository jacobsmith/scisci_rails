class LetsEncryptController < ApplicationController
  def challenge
    head :unauthorized unless params[:challenge] == ENV["LETS_ENCRYPT_CHALLENGE"]
    render text: ENV["LETS_ENCRYPT_RESPONSE"]
  end
end
