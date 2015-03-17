#Blue Harvest

An employee management system

###Status

In development, not usable yet.

###Project Layout

BlueHarvest.NET - The beginnings of an ASP.NET MVC and Web API application  
Database - The SQL Server db script

###Development

There are two projects within the BlueHarvest.NET solution that require Bower
for managing web assets. Those projects are WebApp and WebApi. Bower is a
package manager for the web and is absolutely perfect for managing things like
Bootstrap, Lodash, jQuery, etc...

Bower was chosen because of some difficulties in using Nuget to manage these
dependencies. Either the dependencies were out of date or would not install
correctly within the F# projects.

In order to install Bower you need to install io.js:

https://iojs.org/en/index.html

io.js is a server side JavaScript platform which is required to run Bower.

Once you install io.js you will be able to install Bower using npm (the node
package manager):

http://bower.io/

```
npm install -g bower
```

If all went well you will now be able to use bower to grab the dependencies for
WebApp and WebApi.

From a command prompt navigate to the WebApp and WebApi folders and issue the
following command:

```
bower install
```

NOTE: Make sure you do that for both the WebApp and WebApi projects.

This will install all of the bower managed dependencies. The results will be
located under the bower_components folder. If new dependencies are required you
can add then using the following command:

```
bower install <package>
```

Where <package> is the name of the package, eg. jquery.

The SQL script in the Database folder is a SQL Server database script that is
used to create the initial database.

NOTE: Once the database is created you'll need to change the SQL connection
string in the WebApp web.config so that it can find the database. Additionally
there is a project in the solution named Data that contains a file called
Scratch.fsx. This is a database bootstrapping script that can be used via F#
interactive to bootstrap the database with some fake data. This script may or
may not be up to date, LOL! This however will be well maintained in the future
and bootstrap a DB that is fully capable to show off all features (once they are
developed that is).

That's it! Everything else can be done in Visual Studio. The .NET dependencies
are managed via Nuget so there is no need to do anything since the project is
set up to do a package restore on first build.

###License

GPLv2

