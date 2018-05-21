# README
### 1- Installing Ruby

- Clone the repository by running `git clone git@github.com:lmasello/oupa-api.git`
- Go to the project root by running `cd oupa-api`
- Download and install [Rbenv](https://github.com/rbenv/rbenv#basic-github-checkout).
- Download and install [Ruby-Build](https://github.com/rbenv/ruby-build#installing-as-an-rbenv-plugin-recommended).
- Install the appropriate Ruby version by running `rbenv install [version]` where `version` is the one located in [.ruby-version](.ruby-version)

### 2- Installing Rails gems

- Install [Bundler](http://bundler.io/).

```bash
  gem install bundler --no-ri --no-rdoc
  rbenv rehash
```
- Install basic dependencies if you are using Ubuntu:

```bash
  sudo apt-get install build-essential libpq-dev nodejs
```

- Install all the gems included in the project.

```bash
  bundle install
```

### Database Setup

Run in terminal:

```bash
  bundle exec rake db:setup
```

```bash
  bundle exec rake db:create db:migrate
```

Your server is ready to run. You can do this by executing `rails server`. Happy coding!
