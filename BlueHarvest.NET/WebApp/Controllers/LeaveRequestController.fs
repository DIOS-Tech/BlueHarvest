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

type ViewType = USER=0 | TEAMLEAD=1 | MANAGER=2   
type UpdateType = ADD=0 | DELETE=1 
type PopUpType = SUCCESS=0 | FAIL=1 | ERROR=2 | INFORMATIONAL=2 | WARNING=2      

type PopupMessage = { popupType : PopUpType; Message :  String; Title : String }

[<Authorize>]
type LeaveRequestController() =
  inherit Controller()

 (* VacationContext db = new VacationContext();
  VacationRequest.lib.SomeCompany_TEAM_EMPLOYEESDataContext employeeTeamsDB = new VacationRequest.lib.SomeCompany_TEAM_EMPLOYEESDataContext();
  VacationRequest.lib.SomeCompanyScheduleDataContext scheduleDB = new VacationRequest.lib.SomeCompanyScheduleDataContext();

  private ActiveDirectory ad = new ActiveDirectory("Organization");
  VacationRequest.lib.SharePointAPI sharepoint = new VacationRequest.lib.SharePointAPI("https://sharepointlink.local.net/_vti_bin/Lists.asmx", "Calendar List Name"); *)


  // Action methods

  member this.Index () =
    setViewType()
    let username = getCurrentUser()
    ViewBag.histories = db.Histories.ToList()
    object myModel = db.Requests.ToList().Where(
            request => request.username.ToLower() == username.ToLower() &&
            request.Status != (Int32)VacationRequest.Models.Status.CANCELLED &&
            request.start_date >= System.DateTime.Now.AddMonths(-1)
            ).OrderBy(request => request.Status).ToList()

    if (VacationRequest.lib.VacationLib.isManager(username))
        this.ManagerIndex(myModel)
    else if (VacationRequest.lib.VacationLib.isTeamLead(username))
        this.TeamIndex(myModel, System.DateTime.Now)
    else
        this.View(myModel)


  member this.TeamIndex ( model : object; startDateRange : DateTime) =
    let username = this.getCurrentUser()
    let teamRequests = db.Requests.ToList().Where(request => 
                                request.TeamLead == username && 
                                request.Status == (Int32)VacationRequest.Models.Status.SUBMITTED).ToList()
    let ViewBag.teamRequests = teamRequests
    this.View(model);


  member this.ManagerIndex ( model : object; searchTeamLead : String) =
    let username = getCurrentUser();
    let ViewBag.teamRequests = db.Requests.ToList().Where(
                                request => request.TeamLead == username &&
                                request.Status == (Int32)VacationRequest.Models.Status.SUBMITTED).ToList()

    letViewBag.recentRequests = getManagerRequests().Except(ViewBag.teamRequests)
          
    // get searchable team leads
    let ViewBag.searchTeamLead = new SelectList(getSearchTeamLeads())
    let ViewBag.searchEngineer = new SelectList(getSearchEngineers())
    this.View(model)


  member this.SearchIndex ( model : object) = 
    this.setViewType()
    let username = getCurrentUser()
    this.View("SearchIndex", model)


  member this.SearchView ( searchTeamLead : String) =
    let username = getCurrentUser()
    ViewBag.dropdownEngineer = getSelectListAvailableEngineers(username)
    this.View("_SearchView")


  [<HttpPost>]
  [<ValidateAntiForgeryToken>]
  member this.SearchView ( searchResult : SearchResult) =
    let username = getCurrentUser()
    let Results = (from request in db.Requests select request).ToList()

    if (searchResult.username != null)
        Results = Results.Where(request => request.username.Contains(searchResult.username)).ToList()
    if (!searchResult.startDate.Year.Equals(1) && !searchResult.endDate.Year.Equals(1))
        Results = Results.Where(request => request.start_date >= searchResult.startDate &&
                                request.end_date <= searchResult.endDate).ToList()
    else if (searchResult.startDate.Year.Equals(1) && !searchResult.endDate.Year.Equals(1))
        Results = Results.Where(request => request.end_date <= searchResult.endDate).ToList()
    else if (!searchResult.startDate.Year.Equals(1) && searchResult.endDate.Year.Equals(1))
        Results = Results.Where(request => request.start_date >= searchResult.startDate).ToList()

    this.SearchIndex(Results)


  member this.Details ( id : int) =
    let username = getCurrentUser()    
    let request = db.Requests.Find(id)
    this.setViewType()

    if (request == null)
        failwith "Bad request passed"
    else
        this.View(request)


  //
  // GET: /Request/Create

  member this.Create () =
    let username = getCurrentUser()
    this.setViewType()
    ViewBag.dropdownEngineer = getSelectListAvailableEngineers(username); // new SelectList(getAvailableEngineers());
    ViewBag.dropdownLeaveType = getSelectListLeaveTypes();
    this.View()

  //
  // POST: /Request/Create

  [<HttpPost>]
  [<ValidateAntiForgeryToken>]
  member this.Create (employee) =
    let username = getCurrentUser()
    this.setViewType()
    let request.TeamLead = VacationRequest.lib.VacationLib.getTeamLead(request.username)
    let request.Status = (Int32)VacationRequest.Models.Status.SUBMITTED

    if (ModelState.IsValid && validateStartAndEndDates(request.start_date, request.end_date))
    {
        db.Requests.Add(request)
        db.SaveChanges()
        AppendHistory(request, ChangeType.SUBMIT)
        _SubmittedEmailer_(request)
        RedirectToAction("Index")
    }
    else if (!ModelState.IsValid)
        failwith "Database Connection Error"
    else
        setPopupMessage(new PopupMessage()
        {
            Message = "Start and end dates are not possible, please correct and resubmit",
            Title = "Date Error Encountered",
            popupType = PopUpType.ERROR
        })
        this.View("Edit", request)


  //
  // GET: /Request/Edit

  member this.Edit (id:int) =
    let username = this.getCurrentUser()
    this.setViewType()
    let request = db.Requests.Find(id)

    if (ViewBag.popup == null)
        ViewBag.popup = false
            
    if (request == null)
        failwith "Database Communication Error"
    else if (VacationRequest.lib.VacationLib.isManager(username) || request.TeamLead.Equals(username) || request.username.ToLower().Equals(username.ToLower()) || request.Status.Equals(VacationRequest.Models.Status.SUBMITTED) || request.Status.Equals(VacationRequest.Models.Status.DENIED))
        this.View(request)
    else
        failwith "Access Denied"

  //
  // POST: /Request/Edit/5

  [<HttpPost>]
  [<ValidateAntiForgeryToken>]
  member this.Edit (request) =
    let username = getCurrentUser();
    this.setViewType()

    request.TeamLead = VacationRequest.lib.VacationLib.getTeamLead(request.username);

    if (ModelState.IsValid && validateStartAndEndDates(request.start_date, request.end_date))
    {
        updateChangedDatabase(request, ChangeType.EDIT)
        RedirectToAction("Index")
    }
    else if (!ModelState.IsValid)
        failwith "Database Communication Error"
    else
    {
        ViewBag.popup = true;
        ViewBag.popupMessage = new PopupMessage()
        {
            Message = "Start and end dates are not possible, please correct and resubmit",
            Title = "Date Error Encountered",
            popupType = PopUpType.ERROR
        }
    }

    this.View(request)


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



  // Html Helpers

  member this.setPopupMessage ( popup : PopupMessage) =
    if (popup != null)
    {
        ViewBag.popup = true
        ViewBag.popupMessage = popup
    } else
        ViewBag.popup = false
  

  member this.getCurrentUser() = 
    User.Identity.Name.ToString().ToLower().Replace('dahq\\', '')



  // Code Helpers
  
  member this.setupMailHost (sam_Recipient : String; sam_ccAddresses : String[]) =
    EmailLibrary.From("serviceaccount@local.com")
    EmailLibrary.Host("smtphost.local.com")
    EmailLibrary.To(this.getMailAddress(sam_ccAddresses).ToString())
    if (sam_ccAddresses != null)
      sam_ccAddresses.ToList().ForEach(user => EmailLibrary.addCCAddresses(this.getMailAddress(user)))


  member this.getMailAddress (username : String) =
    let de = ad.GetObjectBySAM(username);
    let email = ad.GetStringProperty(de, "mail").ToString();
    if (email == "")
      yield new MailAddress("webmaster@local.com")
    else
      yield MailAddress(email)



  // Logic Handlers

  member this.validateStartAndEndDates ( start : DateTime; end = DateTime ) =
    if (start < end)
        true
    else
        false



  // DB Queries

  member this.getSearchTeamLeads () =
    let teamLeadList = new List<String>().AddRange((from request in db.Requests
                               orderby request.TeamLead
                               select request.TeamLead).Distinct())


  member this.getSearchEmployees () =
    let engineerList = new List<String>().AddRange((from request in db.Requests
                                   orderby request.username
                                   select request.username).Distinct())


  member this.getAvailableEmployees () = 
    let engineers = new List<String>().AddRange((from engineer in scheduleDB.Employees
                                orderby engineer.samaccount
                                select engineer.samaccount).Distinct());


  member this.getManagerRequests () = 
    let recentRequests = db.Requests.ToList().Where(request =>
                                            request.start_date >= System.DateTime.Now.AddMonths(-1) &&
                                            request.Status == (Int32)VacationRequest.Models.Status.SUBMITTED).ToList()
