namespace BlueHarvest.Controllers

open System
open System.Collections.Generic
open System.Linq
open System.Web
open System.Web.Configuration
open System.Web.Mvc
open System.Web.Mvc.Ajax

open BlueHarvest.Infrastructure.Helpers

type HomeController() =
    inherit Controller()
    member this.Index () = this.View()
    
    member this.About () =
      this.ViewData?Message <- "Your application description page."
      this.View()

    member this.Contact() =
      this.ViewData?Message <- "Your contact page."
      this.View()