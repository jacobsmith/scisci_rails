require 'spec_helper'

describe Project do
  let!(:user) { create(:user) }
  let!(:project) { create(:project, user: user) }
  let!(:source) { create(:source, project: project)}
  let!(:note_with_tags) { create(:note, source: source, tags: "tag1, tag2, tag3")}

  it "requires a name and user to be valid" do
    project.should be_valid
  end

  it "returns all owned tags with #tags" do
    project.tags.should include "tag1", "tag2", "tag3"
  end
end
