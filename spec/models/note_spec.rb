require 'spec_helper'

describe Note do
  let(:note) { create(:note) }
 
 it "accepts valid information" do
    note.should be_valid
  end

  it "does not accept invalid information" do
    note.quote = ''
    note.comments = ''
    note.save
    note.should_not be_valid
  end
  
  let(:note_with_tags) { create(:note, tags: "tag1, tag2, tag3") }

  it "has many tags" do
    note_with_tags.tags.map(&:name).should include 'Tag1'
    note_with_tags.tags.map(&:name).should include 'Tag2'
    note_with_tags.tags.map(&:name).should include 'Tag3'
  end
end
