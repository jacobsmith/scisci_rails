require 'spec_helper'

describe Note do

  
  it "accepts valid information" do
    note.should be_valid
  end

  it "does not accept invalid information" do
    note.quote = ''
    note.comments = ''
    note.save
    note.should_not be_valid
  end

  it "has many tags" do
    let(:note_with_tags) { create(:note, tags: "tag1, tag2, tag3") }
    note.tags.should include %w[tag1 tag2 tag3]
  end
end
