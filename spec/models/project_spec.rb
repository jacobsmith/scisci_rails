require 'spec_helper'

describe Project do
  let!(:project) { build(:project) }
  let!(:tags) { 3.times do |n|
    create(:tag, project: project, name: "tag#{n}" )
  end }
  let(:sources) { 3.times do |n|
    build(:source, project: project) 
  end }

  it "requires a name and user to be valid" do
    project.should be_valid
  end

  it "returns all owned tags with #tags" do
    project.tags.should include "tag0", "tag1", "tag2"
  end

end
