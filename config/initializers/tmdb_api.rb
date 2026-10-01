# Sets the API Key
Tmdb::Api.key(ENV["TMDB_API_KEY"] || Rails.application.credentials.tmdb_api_key)

# Sets the default language
Tmdb::Api.language("en")