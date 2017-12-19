json.extract! encrypted, :id, :msg, :created_at, :updated_at
json.url encrypted_url(encrypted, format: :json)
