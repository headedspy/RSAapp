json.extract! decrypted, :id, :msg, :created_at, :updated_at
json.url decrypted_url(decrypted, format: :json)
