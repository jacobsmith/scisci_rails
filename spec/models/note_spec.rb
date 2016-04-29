require 'spec_helper'

def tags_include(note = nil, *tags)
  tag_list = note.tags.map(&:name)

  tags.each do |tag|
    expect(tag_list).to include tag
  end
end

describe Note do
  let(:note) { build(:note) }

  it "requires quote or comments" do
    note.quote = ''
    note.comments = ''
    expect(note).not_to be_valid
  end

  let(:note_with_tags) { create(:note, tags: "tag1, tag2, tag3") }

  it "has many tags" do
    tags_include(note_with_tags, 'Tag1')
    tags_include(note_with_tags, 'Tag2')
    tags_include(note_with_tags, 'Tag3')
  end

  describe "setting many tags" do
    let(:note) { create(:note, quote: 'This is a test quote', comments: 'This is a test comment') }

    it "accepts tags seperated by comma" do
      note.tags = "tag1, tag2, tag3"
      tags_include(note, 'Tag1', 'Tag2', 'Tag3')
    end

    it "accepts tags seperated by semi-colon" do
      note.tags = "tag4; tag5; tag6"
      tags_include(note, 'Tag4', 'Tag5', 'Tag5')
    end
  end

end
