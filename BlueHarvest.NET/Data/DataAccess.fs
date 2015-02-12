module DataAccess

open System
open System.Data
open System.Data.Linq
open Microsoft.FSharp.Data.TypeProviders
open Microsoft.FSharp.Linq

module SQL =

  //FIXME: This is likely not the connection string you'd use on your system, LOL!
  
  //"Data Source=.\SQLEXPRESS;Initial Catalog=BlueHarvest;Integrated Security=SSPI;"

  type dbSchema = SqlDataConnection<ConnectionStringName="DefaultConnection", ConfigFile="../WebApp/web.config">
  let db = dbSchema.GetDataContext()

  // At this point typing db and hitting . will show you all the tables
  // now. Type Providers are fucking bad ass! There is really no need to create 
  // intermediate data models unless one wants to provide other data access 
  // layers that depend on other types of database systems. 
  //
  // I could see the need for exposing generic data models such that one could
  // swap out back end databases and not have to touch the consumers.
  