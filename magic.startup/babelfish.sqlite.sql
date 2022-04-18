


/*
* Contains all supported languages in the system.
*/
create table languages (
locale TEXT not null,
language TEXT null,
primary key (locale)
);

/* Inserting default language.
*/
insert into languages (locale, language) values ('en', 'English');
insert into languages (locale, language) values ('it', 'Italian');
insert into languages (locale, language) values ('es', 'Spanish');
insert into languages (locale, language) values ('no', 'Norwegian');
insert into languages (locale, language) values ('fr', 'French');
/* Contains all translated units in the system.
*/
create table translations (
id TEXT not null,
locale TEXT not null,
content text null,
primary key (id, locale),
constraint translations_languages_fky foreign key (locale) references languages (locale)
);





