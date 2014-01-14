require 'spec_helper'

describe Tag do
  let(:tag) { create(:tag, name: 'tag_name') }

  describe "with valid information" do
    it "responds to #name" do
      tag.name.should eq 'tag_name'
    end
  end

  let(:blank_tag) { create(:tag, name: '')}

  describe "with invalid information" do
    it "is invalid" do
      blank_tag.should_not be_valid
    end
  end

end
