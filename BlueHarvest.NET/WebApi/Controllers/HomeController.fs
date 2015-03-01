namespace WebApi.Controllers

open System
open System.Collections.Generic
open System.Linq
open System.Web
open System.Web.Mvc
open System.Web.Mvc.Ajax

open WebApi.Infrastructure.Helpers

type HomeController() =
    inherit Controller()
    member this.Index () = this.View()