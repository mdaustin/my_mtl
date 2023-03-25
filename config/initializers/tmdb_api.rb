# Sets the API Key
Tmdb::Api.key(Rails.application.credentials.tmdb_api_key)

# Sets the default language
Tmdb::Api.language("en")