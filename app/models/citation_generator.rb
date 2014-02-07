require 'pry'
class CitationGenerator
  attr_accessor :type

  def initialize(type)
  end

  def generate_citation(options)
   clean_options = clean_hash(options)
   output = ''
   output <<  clean_options[:last_name] + ", " + clean_options[:first_name] + ". "
   output <<  "<i>" + clean_options[:title] + "</i>. "
   output <<  clean_options[:city_of_publication] + ": " if clean_options[:city_of_publication]
   output <<  clean_options[:publisher] + ", "
   output <<  year_of_publication(clean_options[:year_of_publication])
   output <<  clean_options[:medium] + "."

   output
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
