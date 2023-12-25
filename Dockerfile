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

# Copy SSL certificates
COPY ./config/certs/localhost.crt /etc/ssl/certs/
COPY ./config/certs/localhost.key /etc/ssl/private/


# Rails stuff
RUN RAILS_ENV=production
RUN rails assets:precompile

# Add and install tailwindcss
RUN rails tailwindcss:install

# Precompile assets

# Make port 3000 available to the world outside the container
EXPOSE 3000

# Start the main process (Rails Server)
CMD ["rails", "server", "-b", "0.0.0.0"]
# CMD ["rails", "s", "-b", "ssl://0.0.0.0:3000?key=/etc/ssl/private/localhost.key&cert=/etc/ssl/certs/localhost.crt"]

