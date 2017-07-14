require "spec_helper"

RSpec.describe BlogPostsController, type: :controller do
  login_admin

  let(:valid_attributes) do
    {
      title: "Test Blog",
      body: "This is the body of a test blog",
      author: admin
    }
  end

  let(:invalid_attributes) {
    {
      title: "Test Blog",
      body: "This is the body of a test blog",
      author: nil
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # BlogPostsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all blog_posts as @blog_posts" do
      blog_post = BlogPost.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:blog_posts)).to eq([blog_post])
    end
  end

  describe "GET #show" do
    it "assigns the requested blog_post as @blog_post" do
      blog_post = BlogPost.create! valid_attributes
      get :show, {:id => blog_post.to_param}, valid_session
      expect(assigns(:blog_post)).to eq(blog_post)
    end
  end

  describe "GET #new" do
    it "assigns a new blog_post as @blog_post" do
      get :new, {}, valid_session
      expect(assigns(:blog_post)).to be_a_new(BlogPost)
    end
  end

  describe "GET #edit" do
    it "assigns the requested blog_post as @blog_post" do
      blog_post = BlogPost.create! valid_attributes
      get :edit, {:id => blog_post.to_param}, valid_session
      expect(assigns(:blog_post)).to eq(blog_post)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new BlogPost" do
        expect {
          post :create, {:blog_post => valid_attributes}, valid_session
        }.to change(BlogPost, :count).by(1)
      end

      it "assigns a newly created blog_post as @blog_post" do
        post :create, {:blog_post => valid_attributes}, valid_session
        expect(assigns(:blog_post)).to be_a(BlogPost)
        expect(assigns(:blog_post)).to be_persisted
      end

      it "redirects to the created blog_post" do
        post :create, {:blog_post => valid_attributes}, valid_session
        expect(response).to redirect_to(BlogPost.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved blog_post as @blog_post" do
        post :create, {:blog_post => invalid_attributes}, valid_session
        expect(assigns(:blog_post)).to be_a_new(BlogPost)
      end

      it "re-renders the 'new' template" do
        post :create, {:blog_post => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          title: "Test Blog 2",
          body: "This is the body of a test blog",
          author: admin
        }
      }

      it "updates the requested blog_post" do
        blog_post = BlogPost.create! valid_attributes
        put :update, {:id => blog_post.to_param, :blog_post => new_attributes}, valid_session
        blog_post.reload
        expect(blog_post.title).to eq "Test Blog 2"
      end

      it "assigns the requested blog_post as @blog_post" do
        blog_post = BlogPost.create! valid_attributes
        put :update, {:id => blog_post.to_param, :blog_post => valid_attributes}, valid_session
        expect(assigns(:blog_post)).to eq(blog_post)
      end

      it "redirects to the blog_post" do
        blog_post = BlogPost.create! valid_attributes
        put :update, {:id => blog_post.to_param, :blog_post => valid_attributes}, valid_session
        expect(response).to redirect_to(blog_post)
      end
    end

    context "with invalid params" do
      it "assigns the blog_post as @blog_post" do
        blog_post = BlogPost.create! valid_attributes
        put :update, {:id => blog_post.to_param, :blog_post => invalid_attributes}, valid_session
        expect(assigns(:blog_post)).to eq(blog_post)
      end

      it "re-renders the 'edit' template" do
        blog_post = BlogPost.create! valid_attributes
        put :update, {:id => blog_post.to_param, :blog_post => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested blog_post" do
      blog_post = BlogPost.create! valid_attributes
      expect {
        delete :destroy, {:id => blog_post.to_param}, valid_session
      }.to change(BlogPost, :count).by(-1)
    end

    it "redirects to the blog_posts list" do
      blog_post = BlogPost.create! valid_attributes
      delete :destroy, {:id => blog_post.to_param}, valid_session
      expect(response).to redirect_to(blog_posts_url)
    end
  end

end
