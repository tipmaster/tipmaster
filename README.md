# tipmaster
Codebase for the German Soccer Fantasy Game TipMaster

## Project Structure
Quick introduction to the overall project strcuture
* /tmsrc/cgi-bin - User facing scripts which do not use a 'use strict' approach
* /tmsrc/cgi-mod - User facing scripts which do  use a 'use strict' approach
* /tmsrc/cronjobs - Background process scripts for periodic runs such as determining results of games
* /tmsrc/utility - Utiliy scripts for the TipMaster
* /tmstatic/www - All static files hostes on the TipMaster server

## Important Notes
The TipMaster perl codebase is 20 years old and was developed by a very young, unexperienced developer not using OO standards, proper naming standards, or other development best practices.

## Running a local version
If you would like to become a more dedicated contributor to the Tipmaster code base please email info@tipmaster.de and we can share details on how to stand up a local envirnoment and receive a local data dump.
