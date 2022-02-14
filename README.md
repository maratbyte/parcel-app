# Parcel Delivery App
Simple Web App for requesting shipping quotes.
* Made as a test project for [_JetRuby Agency_](https://jetruby.com/)

## Installation
To run the app you should have the following installed on your system:
* Ruby 3.0.3
* Rails 6.1.4.4
* PostgreSQL 14


## Getting started
To get started with the app, clone the repo and change into the project directory
```bash
$ cd parcel-delivery-app
```

Install required gems
```bash
$ bundle install
```

Create a database and run migrations
```bash
$ rails db:create
$ rails db:migrate
```

You can also seed the database with initial fake data (optional)
```bash
$ rails db:seed
```

Next, run tests to verify that everything is working. 
**Warning:** occasionally a couple tests may fail due to hitting a query limit (app uses Google Maps API to calculate distance). This issue will be fixed in the nearest future.
```bash
$ rails test:all
```

Finally, start the rails server and open the app in your browser of choice
```bash
$ rails s
```

## Usage
The app will ask your to enter the following information about the parcel you want to send
* **Weight** (kg), **length** (cm), **width** (cm) and **height** (cm) of the package
  * They should be whole numbers
* **Origination** & **Destination** cities
  * They should be valid city names and contain one or more words separated by either a space or a dash sign. You can also enter an optional state and/or country (separate them with commas).
* Your name and contact information


Provided with a valid input, the app will redirect you to the newly created parcel page, where you can see all it's attributes, edit them, or delete the parcel entirely. You can also hit the "All Parcels" button to see the index page of all parcels.

The app also provides you with an Admin Panel that you can visit by clicking "Admin Panel" link at the navigation bar that is located at the top of the screen. It lets you create, edit and deleted parcels. It also provides you with a nice table view of all the parcels that has been created.
