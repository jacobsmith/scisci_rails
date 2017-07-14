require 'spec_helper'

RSpec.describe "blog_posts/index", type: :view do
  before(:each) do
    assign(:blog_posts, [
      BlogPost.create!(
        :title => "Title",
        :body => "MyText",
        :author => "Author"
      ),
      BlogPost.create!(
        :title => "Title",
        :body => "MyText",
        :author => "Author"
      )
    ])
  end

  it "renders a list of blog_posts" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Author".to_s, :count => 2
  end
end
