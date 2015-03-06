#Blue Harvest

An employee management system

###Status

In development, not usable yet.

###Project Layout

BlueHarvest.NET - A .NET based ASP.NET MVC and Web API application  
Database - This contains the initial SQL Server db script

###Development

Requirements:  

After cloning the repo peform these steps to download dependencies:

**BlueHarvest.NET**: io.js, bower, Visual Studio 2013, SQL Server or SQL Server Express

Open a command prompt to BlueHarvest.NET/WebApp and BlueHarvest.NET/WebApi and run 'bower install' 
so that all bower managed dependencies (eg. jquery, bootstrap, etc...) are installed.

NOTE: Use BlueHarvest.sql in the Database folder to build the database. Change 
the connection string in the web.config file to point to your server.

NOTE: Upon first build all Nuget managed dependencies should download 
automatically

###License

GNU GPL v2

http://www.gnu.org/licenses/gpl-2.0.html
