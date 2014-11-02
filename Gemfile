source "https://rubygems.org"

gem "sinatra"
# Sinatra is a simple web application framework

gem "datamapper"
# DataMapper is a library for interacting with databases

gem "rack-flash3"

gem "sinatra-redirect-with-flash"

group :development do
  # `group`s allow you to not install certain gems in certain environments.
  # It lets you "skip" installing gems, based upon where the application is
  # running: http://bundler.io/v1.6/groups.html
  #
  # For instance, on your personal computer (i.e. :development) we"re going to
  # use `sqlite3` for our database. Sqlite is easy to use because:
  #   * It doesn"t rquire you to install and run a `database server`
  #   * It stores the database as a `file` in your project directory
  #
  # On Heroku (i.e. :production) we"re going to use the `postgres` database. Postgres is reliable,
  # fast, supports many users accessing it at once, and is kind of a pain to get
  # working on your local computer.
  #
  # Heroku wants to skip gems like `sqlite3` that are only useful in
  # development.
  #
  # If you look closely when you push your application to heroku, you"ll see the
  # line: `bundle install --without development, test`; which it uses to skip
  # installing any gems inside of the :development or :test groups.

  gem "sqlite3"
  # `sqlite3` lets your program interact with the `sqlite` database on your
  # computer.

  gem "dm-sqlite-adapter"
  # `dm-sqlite-adapter` lets you use datamapper with sqlite3.

  gem "dotenv"
  # `dotenv` lets you load configuration variables into your program.

  gem "rerun"
  # `rerun` watches your files for saves; and re-executes a command every time
  # files are changed. Use `rerun -x rackup` in lieu of plain `rackup` and never
  # worry about restarting the server after code changes again!
end

group :production do
  # When we install gems locally, we"ll use `bundle install --without production`.
  # Why? Because the `pg` gem assumes you have a postgres server installed and
  # running on your computer. (And it"s a pain to get working!)

  gem "pg"
  # `pg` lets your program interact with the postgres database heroku gives you
  # in production:
  #   * https://devcenter.heroku.com/articles/heroku-postgresql#connecting-in-ruby

  gem "dm-postgres-adapter"
  # `dm-postgres-adapter` lets you use datamapper with postgres.
end
