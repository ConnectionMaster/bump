# Bump

[![Build Status](https://circleci.com/gh/gocardless/bump/tree/master.svg?style=svg)](https://circleci.com/gh/gocardless/bump)

Bump helps you keep your project's Ruby, Node and Python dependencies up to date. It:

- Checks for updates to each of your dependencies.
- Builds an updated dependency file for each update required.
- Opens a separate Pull Request for each update, linking to a changelog.

All that's left for you to do is review the change.

Note: to run Bump on Node projects, they need to be using [Yarn](https://yarnpkg.com).

### Hosting Bump
You can launch your own instance of Bump via Heroku.

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

Once you've deployed, you'll want to click through to Heroku Scheduler in the
list of addons and set up a scheduled task to bump your dependencies each day.
You can use the `./bin/bump_dependencies_for_repo` script to do this:

```
bundle exec bin/bump_dependencies_for_repo gocardless/bump ruby
```

### Using Bump from your local machine

You can run Bump locally to kick-off a one-off update of your project's
dependencies. Bump will ask you for the project's repository and the language of
the dependencies you'd like to update.

1. Pull down bump and install its dependencies:
  ```bash
  git clone git@github.com:gocardless/bump.git  # Pull down Bump
  cd bump && bundle install                     # Install Bump's dependencies
  cp config/dummy_env .env                      # Set up your environment

  # You'll also need to update the `BUMP_GITHUB_TOKEN` in .env to be a valid
  # token with access to your project and all of its private dependencies.
  ```

2. Start a worker for each queue. We use [foreman](http://ddollar.github.io/foreman/) to automate the process:
  ```bash
  bundle exec foreman start
  ```

3. In a new window, push a message to `DependencyFileFetcher` (the first of Bump's services):
  ```bash
  bundle exec bin/bump_dependencies_for_repo
  ```

# The code / contributing

The core logic behind Bump lives in [bump-core](https://github.com/gocardless/bump-core).

---

GoCardless ♥ open source. If you do too, come [join us](https://gocardless.com/about/jobs/software-engineer/).
