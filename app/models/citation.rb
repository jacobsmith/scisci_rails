class Citation
  def generate_citation(source)
    opts = OpenStruct.new
    opts.key = ENV["EASYBIB_KEY"]
    opts.source = source.source_type
    opts[source.citation_type] = source.citation_type_options
    opts.style = "mla7"

    opts.pubtype = OpenStruct.new(main: source.pubtype)
    opts[source.pubtype] = source.pubtype_expanded
    opts.contributors = source.authors_info

    payload = openstruct_to_hash(opts)
    make_http_call(payload)
  end

  private

  def make_http_call(payload)
    uri = URI("https://api.citation-api.com/2.1/rest/cite")
    request = Net::HTTP::Put.new(uri)
    # request.set_form_data(JSON.parse(payload.to_json)) # super janky way of deep-stringifying keys

    request.body = JSON.parse(payload.to_json).to_json

    binding.pry
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    response = http.request(request)

    puts response.body
  end

  def openstruct_to_hash(object, hash = {})
    object.each_pair do |key, value|
      hash[key] = if value.is_a?(OpenStruct)
        openstruct_to_hash(value)
      elsif value.is_a?(Array)
        value.map(&:openstruct_to_hash)
      else
        value
      end
    end
    hash
  end

  def get_source_type(source_type)
    case source_type
    when "book"
      "book"
    when "magazine"
      "magazine"
    when "web"
      "website"
    else
      raise "Unknown source type: #{source_type}"
    end
  end

end
