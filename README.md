# README

This project is called MyMTL (movie tier list). This is a Ruby on Rails 8 app, that allows users to
Sign up and create their own movie tier lists. This app features TMDB API integration and to utilize it you will need to setup
an env variable with your API Key.

## Recent Updates

- Upgraded to Rails 8.1 and Tailwind CSS v4, with a full style refresh 🎬
- Now With Dark Mode 😎
- Style improvements 🎨
- Social Features, follow your friends 🤼🤼
- Hotwire for searching, no more pesky page reload!

## Getting Started

To get started with the app, clone the repo then install the needed gems:

Versions:
Ruby: 3.4.10
Rails: 8.1.4
Tailwind CSS: 4
Development Enviroment needs SQLite3

```
$ gem install bundler
$ bundle config set --local without 'production'
$ bundle install

```

Add the TMDB API key (name it as tmdb_api_key: yourKeyHere ), or set the TMDB_API_KEY environment variable

```
$ rails credentials:edit
```

Next, migrate the DB

```
$ rails db:migrate
```

Then, migrate the test DB

```
$ rails db:migrate RAILS_env=test
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If all passes, you'll be ready to run the app in a local server (this also rebuilds the CSS as you edit):

```
$ bin/dev
```

## Docker instructions

Build the image and run the container:

```
    $ docker build -t mymtl .
    $ docker run -p 3000:3000 mymtl
```

Note: The API key will need to be added to the credentials file prior to creating the container.
