require 'rails_helper'

RSpec.describe "blog_posts/edit", type: :view do
  before(:each) do
    @blog_post = assign(:blog_post, BlogPost.create!(
      :title => "MyString",
      :body => "MyText",
      :author => "MyString"
    ))
  end

  it "renders the edit blog_post form" do
    render

    assert_select "form[action=?][method=?]", blog_post_path(@blog_post), "post" do

      assert_select "input#blog_post_title[name=?]", "blog_post[title]"

      assert_select "textarea#blog_post_body[name=?]", "blog_post[body]"

      assert_select "input#blog_post_author[name=?]", "blog_post[author]"
    end
  end
end
