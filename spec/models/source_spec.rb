require 'spec_helper'

describe Source do

  let!(:user) { create(:user) }
  let!(:project) { create(:project, user: user) }
  let!(:source) { create(:source, project: project) }
 
  let!(:book_source) { create(:source, project: project,
                                       title: "Test title",
                                       authors: "Jacob Smith", 
                                       city_of_publication: "Muncie, Indiana",
                                       year_of_publication: '2014',
                                       publisher: "University Press",
                                       medium: 'Print',
                                       source_type: 'book')}

  let!(:magazine_source) { create(:source, project: project,
                                           authors: "Jacob Smith",
                                           title_of_article: "Test title",
                                           title_of_periodical: "Periodicals Limited",
                                           publication_date: '2014',
                                           pages: '1-3',
                                           source_type: 'magazine')}

  let!(:web_source) { create(:source, project: project,
                                      authors: "Jacob Smith",
                                      name_of_site: 'Test Website',
                                      name_of_organization: 'Test Organization',
                                      date_of_creation: 'March 4, 2014',
                                      date_of_access: 'March 29, 2014',
                                      url: 'http://www.news.ycombinator.com',
                                      source_type: 'web')}
  let!(:note) { create(:note, source: source) }

  it "belongs to a project" do
    source.project.should_not be_nil
  end

  describe "source#display_properties" do
    it "should return a hash of all necessary properties of the source to display for book" do
      book_source.display_properties.should == { title: "Test title", authors: "Jacob Smith", date_published: '2014', publisher: "University Press"}
    end
    
    it "should return a hash of all necessary properties of the source to display for magazine" do
      magazine_source.display_properties.should == { title: "Test title", authors: "Jacob Smith", date_published: '2014', periodical_name: "Periodicals Limited"}
    end
    
    it "should return a hash of all necessary properties of the source to display for web" do
      web_source.display_properties.should == { title: "Test Website", authors: "Jacob Smith", date_published: 'March 4, 2014', url: "http://www.news.ycombinator.com"}
    end
  end
end
