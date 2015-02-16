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

  def tags_include(*tags)
    tags.each do |tag|
      note.tags.map(&:name).should include tag
    end
  end

  describe "setting many tags" do
    let(:note) { create(:note, quote: 'This is a test quote', comments: 'This is a test comment') }

    it "accepts tags seperated by comma" do
      note.tags = "tag1, tag2, tag3"
      tags_include 'Tag1', 'Tag2', 'Tag3'
      note.should be_valid
    end
    
    it "accepts tags seperated by semi-colon" do
      note.tags = "tag1; tag2; tag3"
      tags_include 'Tag1', 'Tag2', 'Tag3'
      note.should be_valid
    end
  end

end
