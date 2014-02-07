require 'pry'
class CitationGenerator
  attr_accessor :type

  def initialize(type)
  end

  def generate_citation(options)
    case options[:type]
    when 'book'
      mla_book_generate_citation(options)
    when 'magazine'
      mla_magazine_generate_citation(options)
    end
  end
  
  private

  def mla_book_generate_citation(options)
   clean_options = clean_hash(options)
   output = ''
   output <<  authors(clean_options[:authors])
   output <<  "<i>" + clean_options[:title] + "</i>. "
   output <<  clean_options[:city_of_publication] + ": " if clean_options[:city_of_publication]
   output <<  clean_options[:publisher] + ", "
   output <<  year_of_publication(clean_options[:year_of_publication])
   output <<  clean_options[:medium] + "."

   output
  end

  def mla_magazine_generate_citation(options)
   clean_options = clean_hash(options)
   output = ''
   output <<  authors(clean_options[:authors])
   output <<  %{"#{clean_options[:title_of_article]}." }
   output <<  "<i>" + clean_options[:title_of_periodical] + "</i> "
   output <<  clean_options[:publication_date] + ": "
   output <<  clean_options[:pages] + ". "
   output <<  clean_options[:medium] + "."

   output
  end
  
  def authors(option)
    author_string = ''
    option.each_with_index do |author, index|
      if author =~ /,/
        author_string += author
        author_string += index == option.length - 1 ? ". " : "and , "
      else
        name = author.split(" ")
        author_string += name[1] + ", " + name[0]
        author_string += index == option.length - 1 ? ". " : "and , "
      end
    end
    author_string
  end

  def year_of_publication(option)
    if option
      option.to_s + ". "
    else
      'n.d. '
    end
  end
  
  def clean_hash(options)
    clean_options = {}
    options.map do |key, value|
      if value == ''
        clean_options[key] = nil
      else
        clean_options[key] = value
      end
    end
    clean_options
  end

end
