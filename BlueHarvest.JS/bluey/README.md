#Bluey

An Atom-Shell sandbox for prototyping UI, business logic and helping to drive development along...

###Roadmap

Once some of the core stuff is figured out and how the data will flow and what all of the requirements
will look like I'd expect to start an Express based web API and then start hooking into that from Bluey.

For now all of the data will be naively stored in json files and loaded at runtime. We'll pretend that
there are only a few users and store that locally as well. We'll shove a super simple login prompt to 
simulate logging into the app.

More to come...

###Development Requirements

Atom-Shell - A shell based on io.js and Chrome.
6to5 - Gonna take advantage of all that ES6 hotness!
Bower - package management for various libraries such as React, jQuery, lodash, etc...


###License

GPLv2