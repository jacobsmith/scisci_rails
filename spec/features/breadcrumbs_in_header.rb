require 'spec_helper'

describe "Bread Crumbs" do
  let(:logged_in_user) { create(:logged_in_user) }
  let!(:project) { create(:project, name: "Breadcrumb Project")}
  let!(:source) { create(:source, project: project, title: "Breadcrumb Source")}
  let!(:note) { create(:note, source: source, quote: "These are some quotes",
                       comments: "These are some comments")}

  it "should display just project name on specific project path" do
    visit project_path(project)
    page.should have_content("Breadcrumb Project")
  end

  it "should display project and source name on source path" do
    visit source_path(source)
    page.should have_content("Breadcrumb Project / Breadcrumb Source")
  end

  it "should display project, source, and note name on note path" do
    visit note_path(note)
    page.should have_content("Breadcrumb Project / Breadcrumb Source / These are some quotes")
  end

  it "should truncate each title at 30 characters" do
  end
end
