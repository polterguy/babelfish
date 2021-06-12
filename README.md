
# Babelfish backend

Babelfish is an enterprise translation micro service for apps needing to translate small pieces of text
to multiple languages. In addition to an administrative backend, it contains two publicly available
endpoints, intended for being used by for instance frontend applications, needing to translate small
snippets of text to multiple languages. The project builds upon these building blocks.

* .Net 5
* MySQL or Microsoft SQL Server
* Magic and Hyperlambda

## Structure

The project contains two main entities that are persisted into the database as tables having the
same name.

* `languages` - These are languages the system support such as Italian, Spanish, Eniglish, Norwegian etc.
* `translations` - These are translated entites in the database, and are each associated with one language.

Each translation belongs to one language, and each language can have multiple translations.

### Definitions

The following words have the following meaning in the system.

* `language` - One supported language in the system such as Italian, Spanish, English etc.
* `translation` - One translated word, phrase, or piece of text, associated with one language, having the translated text as its content in the _"locale"_ of the language.
* `admin` - One administrative user having access to modify the database of translations.
* `client` - Client system consuming the translations to display to its end users.
* `dashboard` - An administrative UI component allowing an admin to edit the database of translations and languages through a UI.
* `end user` - The end user wanting to see your application in his language of choice.

## Publicly available endpoints

These endpoints requires no authentication and are intended to be invoked by clients
needing to translate buttons, checkboxes, etc, for the end user to see these in his language of
choice.

* __GET__ - `magic/modules/babelfish/public/get-languages` - Returns all supported languages.
* __GET__ - `magic/modules/babelfish/public/get-translations` - Returns all translated entities.

Typically you would invoke the _"get-languages"_ endpoint to retrieve all supported languages, for
then to allow the end user to select a language from for instance a select list populated
by the result of this invocation.

As the user selects a language, you would retrieve translations by invoking the _"get-translations"_
endpoint, passing in the language the user selected. The last invocation requires a **[locale.eq]**
argument, to filter results according to one language, and is one of the returned `locale` values from
the _"get-languages"_ endpoint.

Both of these endpoints are caching their result of 20 minutes by applying the `Cache-Control` HTTP
header before returning the result to the caller.

Typically you would store the selected language in the client, as the end user selects a language -
And as the client initialises the next time, automatically retrieve all translation entities according
to the end user's selection. Probably defaulting to for instance English if the end user has still not
explicitly selected a language.

## Administrative endpoints

In addition to the above publicly available endpoints, the module exposes 12 administrative endpoints,
helping you to administer the system's database of languages and translations. These are as follows.

* __GET__ - `magic/modules/babelfish/admin/languages` - Returns all supported languages.
* __GET__ - `magic/modules/babelfish/admin/languages-count` - Returns the number of languages that exists in its database.
* __POST__ - `magic/modules/babelfish/admin/languages` - Creates a new language.
* __PUT__ - `magic/modules/babelfish/admin/languages` - Updates an existing language.
* __DELETE__ - `magic/modules/babelfish/admin/languages` - Deletes a specific language. Notice, if the language contains translations this wil fail due to referential integrity on the database level. Delete all translations belonging to the language _first_ if you really need to do this.
* __GET__ - `magic/modules/babelfish/admin/translations` - Returns translations according to the specified arguments.
* __GET__ - `magic/modules/babelfish/admin/translations-count` - Returns the number of translations in the system acccording to the specified arguments.
* __POST__ - `magic/modules/babelfish/admin/translations` - Creates a new translation entity given the specified arguments.
* __PUT__ - `magic/modules/babelfish/admin/translations` - Updates an existing translation entity.
* __DELETE__ - `magic/modules/babelfish/admin/translations` - Deletes one specific translation according to the specified arguments.

In addition to the above CRUD endpoints allowing you to administer your database, the system also contains the following
ststistical endpoint, returning information about the state of your database.

* __GET__ - `magic/modules/babelfish/admin/statistics` - Returns statistics about missing translations for missing languages making it easier to see missing translation entities.

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

**Notice** - The system does _not_ translate existing entities when you create new _languages_, only as you create
new translation entities.

## Dashboard

The system comes with a [dashboard admin UI](https://github.com/polterguy/babelfish.frontend) that you can use
in your organisation to allow for translators to easily administrate your translation database.

## Installation

Install into [Magic](https://github.com/polterguy/magic) by unzipping into your `/modules/` folder
as _'babelfish'_ folder. You can play around with the endpoints the app creates for you by using the _'Endpoints'_
menu item in your Magic Dashboard.
