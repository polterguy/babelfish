# Babelfish backend

Allows you to easily translate your enterprise applications, by providing you with a Hyperlambda backend,
containing two HTTP REST GET endpoints.

* GET `magic/modules/babelfish/get-translations` - Returns all translated entities from your babelfish database
* GET `magic/modules/babelfish/get-languages` - Returns all supported languages

In addition, the backend also contains all basic CRUD operation endpoints, to easily allow you to administrate
your translation entities.

## Usage

Install into [Magic](https://github.com/polterguy/magic) by unzipping into your `/backend/files/modules/` folder
as _'babelfish'_ folder. You can play around with the endpoints the app creates for you by using the _'Endpoints'_
menu item in your Magic Dashboard.
