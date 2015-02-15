namespace BlueHarvest

open System
open System.Net.Http
open System.Web
open System.Web.Http
open System.Web.Mvc
open System.Web.Routing
open System.Web.Optimization
open System.Security.Claims
open System.Threading.Tasks
open Microsoft.Owin
open Microsoft.Owin.Security
open Microsoft.AspNet.Identity
open Microsoft.AspNet.Identity.EntityFramework
open Microsoft.AspNet.Identity.Owin

type BundleConfig() =
  static member RegisterBundles (bundles:BundleCollection) =
    bundles.Add(ScriptBundle("~/bundles/jquery").Include([|"~/bower_components/jquery/dist/jquery*"|]))
    bundles.Add(ScriptBundle("~/bundles/jqueryval").Include([|"~/bower_components/jquery-validate/dist/jquery.validate*"|]))

    bundles.Add(ScriptBundle("~/bundles/lodash").Include([|"~/bower_components/lodash/lodash*"|]))

    bundles.Add(ScriptBundle("~/bundles/datatables").Include([|"~/bower_components/datatables/media/js/jquery.dataTables*"|]))

    // Use the development version of Modernizr to develop with and learn from. Then, when you're
    // ready for production, use the build tool at http://modernizr.com to pick only the tests you need.
    bundles.Add(ScriptBundle("~/bundles/modernizr").Include([|"~/bower_components/modernizr/modernizr.js"|]))

    bundles.Add(ScriptBundle("~/bundles/bootstrap").Include(
                    "~/bower_components/bootstrap/dist/js/bootstrap.js",
                    "~/bower_components/respond-minmax/dest/respond.js"))

    bundles.Add(ScriptBundle("~/bundles/blue").Include([|"~/Assets/Scripts/main.js"|]))

    bundles.Add(StyleBundle("~/Content/datatables").Include([|"~/bower_components/datatables/media/css/jquery.dataTables.*"|]))

    bundles.Add(StyleBundle("~/Content/css").Include(
                    "~/Assets/CSS/cosmo-bootstrap.css",
                    "~/Assets/CSS/site.css"))

/// Route for ASP.NET MVC applications
type Route = { 
    controller : string
    action : string
    id : UrlParameter }

type HttpRoute = {
    controller : string
    id : RouteParameter }

type Global() =
    inherit System.Web.HttpApplication() 

    static member RegisterWebApi(config: HttpConfiguration) =
        // Configure routing
        config.MapHttpAttributeRoutes()
        config.Routes.MapHttpRoute(
            "DefaultApi", // Route name
            "api/{controller}/{id}", // URL with parameters
            { controller = "{controller}"; id = RouteParameter.Optional } // Parameter defaults
        ) |> ignore

        // Configure serialization
        config.Formatters.XmlFormatter.UseXmlSerializer <- true
        config.Formatters.JsonFormatter.SerializerSettings.ContractResolver <- Newtonsoft.Json.Serialization.CamelCasePropertyNamesContractResolver()

        // Additional Web API settings

    static member RegisterFilters(filters: GlobalFilterCollection) =
        filters.Add(new HandleErrorAttribute())

    static member RegisterRoutes(routes:RouteCollection) =
        routes.IgnoreRoute("{resource}.axd/{*pathInfo}")
        routes.MapRoute(
            "Default", // Route name
            "{controller}/{action}/{id}", // URL with parameters
            { controller = "Home"; action = "Index"; id = UrlParameter.Optional } // Parameter defaults
        ) |> ignore

    member this.Application_Start() =
        AreaRegistration.RegisterAllAreas()
        GlobalConfiguration.Configure(Action<_> Global.RegisterWebApi)
        Global.RegisterFilters(GlobalFilters.Filters)
        Global.RegisterRoutes(RouteTable.Routes)
        BundleConfig.RegisterBundles BundleTable.Bundles