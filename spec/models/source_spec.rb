require 'spec_helper'
require 'spec_helper'

describe Source do

  let!(:user) { create(:user) }
  let!(:project) { create(:project, user: user) }
  let!(:source) { create(:source, project: project) }
  let!(:note) { create(:note, source: source) }

  it "belongs to a project" do
    source.project.should_not be_nil
  end
  
  it "has many notes" do
    source.notes.should include note 
  end
end
