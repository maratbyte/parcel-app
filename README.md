# Parcel Delivery App
Simple CLI app for requesting shipping quotes.
* Made as a test project for [_JetRuby Agency_](https://jetruby.com/)

## Installation
To run the app you should have **Ruby** installed on your system

## Getting started
To get started with the app, clone the repo and change into the project directory
```bash
$ cd parcel-delivery-app
```
Next, run tests to verify that everything is working:
```bash
$ ruby parcel_test.rb
```
Finally, run the app
```bash
$ ruby cli_app.rb
```

## Usage
The app will ask your to enter the following information about the parcel you want to send
* **Weight** (kg), **length** (cm), **width** (cm) and **height** (cm) of the package
  * They should be whole numbers
* **Origination** & **Destination** cities
  * They should be valid city names and contain one or more words separated by either a space or a dash sign
```
Welcome to Parcel Delivery Service.
To request a shipping quote, please enter the following information.

Enter parcel weight: 10
Enter parcel length: 50
Enter parcel width: 50
Enter parcel height: 50
Enter origin city: Seattle
Enter destination city: Vancouver
```
Provided with a valid input, the app should print out a shipping quote for you
```
We successfully processed your request. Here is your shipping quote:

Weight   | 10kg
Length   | 50cm
Width    | 50cm
Height   | 50cm
Distance | 454km
Price    | 454rub
```
Finally, it will ask if you would like to make another request. You should answer `yes` or `no`.
```
Would you like to make another request?(yes/no)
no

Thank you for using our service.
```