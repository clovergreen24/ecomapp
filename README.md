# Kawaii Store Backend
Backend side for the e-commerce application for the fictional store Kawaii Store built with Ruby on Rails. This project has a Rails 7 backend API and a separate React-based frontend built with TypeScript and Vite.

## Features
  * User authentication with Devise
  * Product management and shopping cart functionality
  * Stock tracking to ensure availability
  * Graphical reports and statistics via Chartkick and Groupdate
## Prerequisites
* Ruby 3.1.3
* Rails 7.0.8
* SQLite
## Getting Started

1- Clone the repository:
```
git clone https://github.com/clovergreen24/ecomapp.git
cd ecomapp
```
2- Install dependencies:
```
bundle install
```
3- Set up the database:
```
rails db:create db:migrate
```
4- Start the Rails server:
```
rails s
```
## Gems Used

  * devise for authentication
  * tailwindcss-rails for styling
  *  turbo-rails and stimulus-rails for Hotwire functionality
  *  jbuilder for JSON API views
  *  rack-cors for CORS handling
  *  chartkick and groupdate for charting and data grouping
  *  mini_magick for image processing
