#Bluey

An Atom-Shell sandbox for prototyping UI, business logic and helping to drive 
development along...

###Roadmap

Once some of the core stuff is figured out and how the data will flow and what 
all of the requirements will look like I'd expect to start an Express based 
web API and then start hooking into that from Bluey.

For now all of the data will be naively stored in json files and loaded at 
runtime. We'll pretend that there are only a few users and store that locally 
as well. We'll shove a super simple login prompt to simulate logging into the 
app.

More to come...

###Usage

You need io.js and Atom-Shell

- open command line to bluey root
- type: npm install
- type: bower install
- npm install -g grunt-cli
- type: grunt

If you make changes to bluey.es6.js you need to run grunt from the command line
to transpile to es5. 

For now everything in the bluey folder would be copied to atom-shell/resources/app.
The execute atom.exe which is in the root of the atom-shell folder.

I'm going to see if I can make a grunt task (or find a plugin) to make this
easier.

###License

GPLv2
