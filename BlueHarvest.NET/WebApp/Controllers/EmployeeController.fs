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
  // GET: /Employee/Create
  member this.Create () =
    this.View()

  //
  // POST: /Employee/Create
  [<HttpPost>]
  [<ValidateAntiForgeryToken>]
  member this.Create (employee) =
    this.View()

  //
  // GET: /Employee/Edit
  member this.Edit (id:int) =
    this.View()

  //
  // POST: /Employee/Edit
  [<HttpPost>]
  [<ValidateAntiForgeryToken>]
  member this.Edit (employee) =
    this.View()

  //
  // GET: /Employee/Delete
  member this.Delete (id:int) =
    this.View()

  //
  // POST: /Employee/Delete
  [<HttpPost>]
  [<ValidateAntiForgeryToken>]
  member this.Delete (employee) =
    this.View()

  //
  // GET: /Employee/Archive
  member this.Archive (id:int) =
    this.View()

  //
  // POST: /Employee/Archive
  [<HttpPost>]
  [<ValidateAntiForgeryToken>]
  member this.Archive (employee) =
    this.View()