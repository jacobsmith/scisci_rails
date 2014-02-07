require 'spec_helper'

describe CitationGenerator do
  let!(:mla) { CitationGenerator.new(:mla) }

  describe 'returns proper book citation' do
    options = { last_name: 'Smith',
                first_name: 'Jacob',
                title: 'The Art of Writing Code',
                city_of_publication: 'Indianapolis',
                publisher: 'Smith, Inc.',
                year_of_publication: '1992',
                medium: 'Print'}
  
    it 'with good input' do
      expect(mla.generate_citation(options)).to eq "Smith, Jacob. <i>The Art of Writing Code</i>. Indianapolis: Smith, Inc., 1992. Print."
    end
  end

  describe 'returns proper book citation' do
    options = { last_name: 'Smith',
      first_name: 'Jacob',
      title: 'The Art of Writing Code',
      city_of_publication: '',
      publisher: 'Smith, Inc.',
      year_of_publication: '',
      medium: 'Print'}
    it 'when missing inputs' do
      expect(mla.generate_citation(options)).to eq "Smith, Jacob. <i>The Art of Writing Code</i>. Smith, Inc., n.d. Print."
    end
  end
end
