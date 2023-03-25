# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

if User.count == 0
    User.create!(username: "maustin", 
                email: "maustin@mymtl.ca",
                password: "foobar",
                password_confirmation: "foobar",
                admin: true,
                activated: true,
                activated_at: Time.zone.now)

    # Generate 99 users
    99.times do |n|
        username = Faker::Name.unique.name
        email = "example-#{n+1}@example.com"
        password = "password"
        User.create!(username: username.strip,
                    email: email,
                    password: password,
                    password_confirmation: password,
                    activated: true,
                    activated_at: Time.zone.now )
    end
end

# Generate 3 tier lists for the first user
if TierList.count == 0
    user = User.first
    3.times do 
        title = Faker::Lorem.sentence(word_count: 2)
        user.tier_lists.create!(title: title, description: "#{user.username}'s #{user.tier_lists.count.ordinalize} tier list")
    end
end

# Generate 3 tiers for the first tier list
if Tier.count == 0
    tier_list = TierList.first
    for i in 1..3 do
        title = "#{i.ordinalize} Tier"
        tier_list.tiers.create!(title: title)
    end        
end

# Generate 20 movies from TMDB API Popular Movies endpoint
if Movie.count == 0
    Tmdb::Movie.popular.results.each do |movie|
        movie_detail = Tmdb::Movie.detail(movie.id)
        Movie.create!(title: movie_detail.title,
                    overview: movie_detail.overview,
                    release_date: movie_detail.release_date,
                    tmdb_id: movie_detail.id,
                    runtime: movie_detail.runtime.to_i,
                    poster_path: movie_detail.poster_path)
    end
end

# Generate 3 tier_movies for the first tier 
if TierMovie.count == 0
    tier = Tier.first
    3.times do 
        tier.tier_movies.create!(movie_id: Movie.all.sample.id)
    end
end