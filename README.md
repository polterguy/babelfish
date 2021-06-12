
# Babelfish backend

Babelfish is an enterprise translation micro service for apps needing to translate small pieces of text
to multiple languages. In addition to an administrative backend, it contains two publicly available
endpoints, intended for being used by for instance frontend applications, needing to translate small
snippets of text to multiple languages.

## Publicly available endpoints

These endpoints requires no authentication and are intended to be invoked by for instance frontends
needing to translate buttons, checkboxes and such, for the end user to see these in his language of
choice.

* GET `magic/modules/babelfish/public/get-languages` - Returns all supported languages.
* GET `magic/modules/babelfish/public/get-translations` - Returns all translated entities.

Typically you would invoke the _"get-languages"_ endpoint to retrieve all supported languages, for
then to allow the end user to select a language from for instance a drop down select list populated
by the result of this invocation.

Then as the user selects a language, you would retrieve translations by invoking the _"get-translations"_
endpoint, passing in the language the user selected. The last invocation requires a **[locale.eq]**
argument, to filter results according to one language, and is one of the returned `locale` values from
the _"get-languages"_ endpoint.

Both of these endpoints are caching their result of 20 minutes by applying the `Cache-Control` HTTP
header before returning the result to the caller.

## Administrative endpoints

In addition to the above publicly available endpoints, the module exposes 12 administrative endpoints,
helping you to administer the system's database of languages and translations. These are as follows.

* GET `magic/modules/babelfish/admin/languages` - Returns all supported languages.
* GET `magic/modules/babelfish/admin/languages-count` - Returns the number of languages that exists in its database.
* POST `magic/modules/babelfish/admin/languages` - Creates a new language.
* PUT `magic/modules/babelfish/admin/languages` - Updates an existing language.
* DELETE `magic/modules/babelfish/admin/languages` - Deletes a specific language. Notice, if the language contains translations this wil fail due to referential integrity on the database level. Delete all translations belonging to the language _first_ if you really need to do this.
* GET `magic/modules/babelfish/admin/translations` - Returns translations according to the specified arguments.
* GET `magic/modules/babelfish/admin/translations-count` - Returns the number of translations in the system acccording to the specified arguments.
* POST `magic/modules/babelfish/admin/translations` - Creates a new translation entity given the specified arguments.
* PUT `magic/modules/babelfish/admin/translations` - Updates an existing translation entity.
* DELETE `magic/modules/babelfish/admin/translations` - Deletes one specific translation according to the specified arguments.

In addition to the above CRUD endpoints allowing you to administer your database, the system also contains the following
ststistical endpoint, returning information about the state of your database.

* GET `magic/modules/babelfish/admin/statistics` - Returns statistics about missing translations for missing languages making it easier to see missing translation entities.

All of these endpoints requires the user to belong to one of the following roles to allow the user to invoke the endpoint.

* root
* admin
* translator

## Google translate

When and admin user wants to create translation entities, the system allows him to automatically translate whatever
he supplies to the system, to all other supported languages automatically by using Google Translate. This allows the
admin user to supply one translation entity to the system, and having a _"sane default"_ value provided for all other
languages in the database.

Of course, this is _not perfect_, and sometimes Google Translate does a very bad job at translating such phrases
and words - But at least it provides you with a starting ground, significantly simplifying the job of translating
your app, even to languages you do not master.

## Dashboard

The system comes with a [dashboard admin UI](https://github.com/polterguy/babelfish.frontend) that you can use
in your organisation to allow for translators to easily administrate your translation database.

## Installation

Install into [Magic](https://github.com/polterguy/magic) by unzipping into your `/modules/` folder
as _'babelfish'_ folder. You can play around with the endpoints the app creates for you by using the _'Endpoints'_
menu item in your Magic Dashboard.
