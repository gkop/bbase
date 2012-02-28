BBase
=====

BBase is a database, gallery, and social platform for promoting works of visual art.

Getting started
---------------

1. Download and install [MongoDB](http://www.mongodb.org/downloads)
2. `git clone https://github.com/gkop/bbase.git`
3. `cd bbase`
4. `bundle install`
5. `cp config/sensitive.yml.example config/sensitive.yml`
6. Follow the instructions in `config/sensitive.yml` to complete it
7. `rake db:seed`
8. `rails s`

That's it.  Now you should be able to browse to `localhost:3000` and login with the credentials you set above.

Demo
----

You can find a live BBase instance at [Golahny.org](http://golahny.org).

CI
--

[![Build Status](https://secure.travis-ci.org/gkop/bbase.png?branch=master)](http://travis-ci.org/gkop/bbase)

Legal
-----
BBase is copyright Gabe Kopley, 2011, and released under the GNU AGPLv3 license.
