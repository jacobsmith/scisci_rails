require 'rails_helper'

RSpec.describe "BlogPosts", type: :request do
  describe "GET /blog_posts" do
    it "works! (now write some real specs)" do
      get blog_posts_path
      expect(response).to have_http_status(200)
    end
  end
end
