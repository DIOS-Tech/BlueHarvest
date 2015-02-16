namespace BlueHarvest.Controllers

open System
open System.Collections.Generic
open System.Globalization
open System.Linq
open System.Security.Claims
open System.Threading.Tasks
open System.Web
open System.Web.Mvc
open Microsoft.AspNet.Identity
open Microsoft.AspNet.Identity.Owin
open Microsoft.Owin.Security

open BlueHarvest.DataAccess.SQL

[<Authorize>]
type EmployeeController() =
  inherit Controller()

  member this.Index () =
    this.View()

  //
  // ET: /Employee/Create
  //member this.Create () =
  //  this.View()

  //
  // POST: /Employee/Create
  //[<HttpPost>]
  //[<ValidateAntiForgeryToken>]
  //member this.Create (employee) =
  //  this.View()