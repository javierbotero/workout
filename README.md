**WorkOut**

This project was built for the Microverse Ruby on Rails capstone project based on lifestyle articles website template. In this web app, the users can write articles about exercise or workout individually, in groups, indoors, or outdoors. The main features of this app are:

- The user can log in to the app, only by typing the username.
- The user is presented with the homepage.
- Featured article with full-width image and title in the first row. This is an article with the biggest number of votes.
- List of all categories in order of priority. Each category should be displayed as a square with its name on the top and its most recent article's title in the bottom.
When the user clicks the category name they can see all articles in that category and write an article.

## Live preview

[WorkOut App](https://stark-harbor-31329.herokuapp.com/)

![Screenshot app](https://res.cloudinary.com/enterprise/image/upload/v1599836656/WorkOut_c4q4qv.jpg)

## Built With

- Rails 6.0.3.2
- Ruby 2.6.4p104
- Bootstrap
- RSpec
- Cloudinary

## Getting started

To start with the project:

1. This project runs in Ruby and Ruby on Rails. It is recommended that you have installed Ruby 2.6.4p104 and Rails 6.0.3.2 due to this webapp runs in these versions.
2. Fork this repository.
3. Run `bundle install` inside the folder where the app lives.
4. Run rails db:create
5. Run `bin/rails active_storage:install` to generate a migration that creates the two tables needed for the uploading functionality.
6. Because this project relies on Cloudinary vendor for uploading pictures or media to the cloud in all environments, you need to have an account in Cloudinary to run successfully and upload any picture in the local environment. You can find more information about[Cloudinary here](https://cloudinary.com/documentation/rails_integration), and about [active storage here](https://edgeguides.rubyonrails.org/active_storage_overview.html#setup).
7. This project uses environment variables that provide the credentials to access to Cloudinary, because this is sensitive information that should not be uploaded to source control it is recommended that you set up these variables in your environment named the same as in the file config/initializers/cloudinary.rb.
5. Run the migration to database
    - rails db:migrate
6. Run the rails server
    - rails server

## Tests

1. Add rspec-rails to both the :development and :test groups of your app’s Gemfile:
    - group :development, :test do
        gem 'rspec-rails', '~> 4.0.1'
      end
1. After having installed rails in your app run
    - rails generate rspec:install
3. Run `bundle exec rspec`

## Author

👤 **Javier Botero**

- Github: [@Javierbotero](https://github.com/javierbotero)
- Twitter: [@Javierbotero1](https://twitter.com/JavierBotero1)
- Linkedin: [Javierbotero](https://www.linkedin.com/in/javierboterodev/)

## Referents

This project was based on the design idea by [Nelson Sakwa on Behance](https://www.behance.net/sakwadesignstudio)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

## Show your support

Give a ⭐️ if you like this project!
