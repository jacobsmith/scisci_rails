json.array!(@notes) do |note|
  json.extract! note, :id, :quote, :comments
  json.url note_url(note, format: :json)
end
