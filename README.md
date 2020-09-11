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

## Getting start

To start with the project:

1. This project runs in Ruby and Ruby on Rails. It is recommended that you have installed Ruby 2.6.4p104 and Rails 6.0.3.2 due to this webapp runs in these versions.
2. Fork this repository.
3. Run bundle install inside the folder where the app lives.
4. You need to tell Active Storage which service to use by setting Rails.application.config.active_storage.service = :local in config/environments/development.rb and in config/environments/test.rb for the upliadings functionality or set it to your vendor [more info](https://edgeguides.rubyonrails.org/active_storage_overview.html#setup).
5. Run the migration to database
    - rails db:migrate
6. Run the rails server
    - rails server

## Author

👤 **Javier Botero**

- Github: [@Javierbotero](https://github.com/javierbotero)
- Twitter: [@Javierbotero1](https://twitter.com/JavierBotero1)
- Linkedin: [Javierbotero](https://www.linkedin.com/in/javier-botero-044686155/)

## Referents

This project was based on the design idea by [Nelson Sakwa on Behance](https://www.behance.net/sakwadesignstudio)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

## Show your support

Give a ⭐️ if you like this project!