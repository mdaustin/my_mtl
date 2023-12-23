# Use an official Ruby runtime as a parent image
FROM ruby:3.1.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs npm sqlite3
RUN npm install -g yarn

# Set the working directory in the container
WORKDIR /usr/src/app

# Install Gems
COPY Gemfile* Gemfile.lock ./
RUN bundle install

# Copy the current directory contents into the container
COPY . .

# Add and install tailwindcss
RUN rails tailwindcss:install

# Precompile assets
RUN RAILS_ENV=production rails assets:precompile


# Make port 3000 available to the world outside the container
EXPOSE 3000

# Start the main process (Rails Server)
CMD ["rails", "server", "-b", "0.0.0.0"]
