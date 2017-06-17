class GenerateFullBibliography
  attr_reader :success, :error
  attr_accessor :bibliography

  def self.cache_key(project)
    "project_#{project.id}_bibliography_#{project.updated_at}"
  end

  def self.perform(project)
    if Rails.cache.read(cache_key(project))
      Rails.logger.info("Cached bibliography for project: #{project.id}")
      full_bibliography = new(project)
      full_bibliography.bibliography = Rails.cache.read(cache_key(project))
      return full_bibliography
    else
      new(project).perform
    end
  end

  def initialize(project)
    @project = project
    @bibliography = [] # default to empty bibliography array
  end

  def perform
    opts = OpenStruct.new
    opts.key = ENV["EASYBIB_KEY"]
    opts.style = "mla7"
    opts.bulk = @project.sources.map { |source| Citation.new.generate_citation_request_body(SourceCitationDecorator::Base.decorate!(source)) }

    payload = openstruct_to_hash(opts)
    make_http_call(payload)
    self
  end

  def make_http_call(payload)
    uri = URI("https://api.citation-api.com/2.1/rest/bulk")
    request = Net::HTTP::Put.new(uri)

    request_payload = JSON.parse(payload.to_json).to_json # super janky way of deep-stringifying keys
    request.body = request_payload

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    response = http.request(request)

    citation = JSON.parse(response.body)

    @success = citation["status"] == "ok"
    if success?
      @bibliography = citation["data"].map { |response| response["citation"] }
      Rails.cache.write(GenerateFullBibliography.cache_key(@project), @bibliography)
    end

    Rails.logger.info("Citation_Error: #{request_payload} returned #{response.body}") unless success?
    @error = citation["error"]
  end

  def success?
    @success
  end

  private

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

end
