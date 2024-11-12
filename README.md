# tipmaster
Codebase for the German Soccer Fantasy Game TipMaster

[Deutsche Erkl&auml;rung/Introduction in German](#german)

##Technology Stack
* Perl 5.20.1
* CGI::Session
* Lighttpd 1.4.35

## Project Structure
Quick introduction to the overall project strcuture
* /tmsrc/cgi-bin - User facing scripts which do not use a 'use strict' approach
* /tmsrc/cgi-mod - User facing scripts which do  use a 'use strict' approach
* /tmsrc/cronjobs - Background process scripts for periodic runs such as determining results of games
* /tmsrc/utility - Utiliy scripts for the TipMaster
* /appdata - Data that is meant to be amanged through Github; all internal data is mounted at /tmdata but not accessible through Github as of right now
* /tmstatic/www - All static files hostes on the TipMaster server

## How to contribute
To propose any changes tp the source code please create a [pull request](https://help.github.com/articles/creating-a-pull-request/)

## Important Notes
The TipMaster perl codebase is 20 years old and was developed by a very young, unexperienced developer not using OO standards, proper naming standards, or other development best practices.

## Running a local version
If you would like to become a more dedicated contributor to the Tipmaster code base please email info@tipmaster.de and we can share details on how to stand up a local envirnoment and receive a local data dump.

## <a name="german"></a> Deutsche Erkl&auml;rung
Auf dieser Seite finden Sie den Programmiercode der die TipMaster Seite seit 20 Jahren realisiert. Ueber das Github Protokol ist der Programmiercode nun Open Source und kann dadurch - unter Moderation - von Mitspielern mitgestaltet werden. So koennen Fehler schneller behoben werden und neue Funktionalitaet durch die Gemeinschaft hunzigef&uuml;gt werden. Um Dateien im Projekt zu &auml;ndern ist ein Pull Request n&ouml;tig. 

Eine [deutsche Anleitung](https://git-scm.com/book/de/v1/Distribuierte-Arbeit-mit-Git-xxx-An-einem-Projekt-mitarbeiten) zur Mitarbeit an einem Git Projekt finden Sie hier.

