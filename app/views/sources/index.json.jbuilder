json.array!(@sources) do |source|
  json.extract! source, :id, :title, :author, :url, :comments
  json.url source_url(source, format: :json)
end
