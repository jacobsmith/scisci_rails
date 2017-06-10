class Citation
  # http://developer.easybib.com/citation-formatting-api/citation-specification/

  attr_accessor :succes, :error, :formatted_citation

  def generate_citation(source)
    # Give a decent error message as a default - should be overridden after http call succeeds
    @formatted_citation = "Oops! Something went wrong. Please try again!"

    opts = OpenStruct.new
    opts.key = ENV["EASYBIB_KEY"]
    opts.source = source.citation_type
    opts[source.citation_type] = source.citation_type_options
    opts.style = "mla7"

    opts.pubtype = OpenStruct.new(main: source.pubtype)
    opts[source.pubtype] = source.pubtype_expanded
    opts.contributors = source.authors_info

    payload = openstruct_to_hash(opts)
    make_http_call(payload)
    self
  end

  def success?
    @success
  end

  private

  def make_http_call(payload)
    uri = URI("https://api.citation-api.com/2.1/rest/cite")
    request = Net::HTTP::Put.new(uri)

    request_payload = JSON.parse(payload.to_json).to_json # super janky way of deep-stringifying keys
    request.body = request_payload

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    response = http.request(request)

    citation = JSON.parse(response.body)

    @success = citation["status"] == "ok"
    @formatted_citation = citation["data"] if success?

    Rails.logger.info("Citation_Error: #{request_payload} returned #{response.body}") unless success?
    @error = citation["error"]
  end

  def openstruct_to_hash(object, hash = {})
    object.each_pair do |key, value|
      hash[key] = if value.is_a?(OpenStruct)
        openstruct_to_hash(value)
      elsif value.is_a?(Array)
        value.map { |member_of_value| openstruct_to_hash(member_of_value) }
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
