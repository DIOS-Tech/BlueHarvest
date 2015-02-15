#Blue Harvest

An employee management system

###Status

Still in the early stages of discussion, no real useful stuff here yet.

###Project Layout

BlueHarvest.NET - A .NET based ASP.NET MVC and Web API application  
BlueHarvest.JS - An io.js / Atom-Shell prototype sandbox  
Database - This contains the initial SQL Server db script as well as an
SQL Server backup that also provides a database diagram.

###Development

Requirements:  

After cloning the repo peform these steps to download dependencies:

**BlueHarvest.NET**: io.js, bower, Visual Studio 2013, SQL Server or SQL Server Express

Open a command prompt to BlueHarvest.NET/WebApp and run 'bower install' so that
all bower managed dependencies (eg. jquery, bootstrap, etc...) are installed.

NOTE: Use BlueHarvest.sql in the Database folder to build the database. Change 
the connection string in the web.config file to point to your server.

NOTE: Upon first build all Nuget managed dependencies should download 
automatically

**BlueHarvest.JS**: io.js, bower

Open a command prompt to BlueHarvest.JS/harvey and run 'npm install' and then 
'bower install' so that all dependencies are installed.

###License

GNU GPL v2

http://www.gnu.org/licenses/gpl-2.0.html
