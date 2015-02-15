
// This code is for F# Interactive. 
// This is a sandbox to play with various things.

// Evaluate the entire file in F# Interactive to bootstrap the
// database in it's current form.

#r "System.dll"
#r "System.Data.Linq"
#r "FSharp.Data.TypeProviders.dll"
#r "../packages/FSharp.Data.2.1.1/lib/net40/FSharp.Data.dll"

open System
open System.Data
open System.Data.Linq
open Microsoft.FSharp.Data.TypeProviders
open Microsoft.FSharp.Linq
open FSharp.Data

type EmployeeData = JsonProvider<"../../Database/data.json">
type dbSchema = SqlDataConnection<ConnectionStringName="DefaultConnection", ConfigFile="../WebApp/web.config">
let db = dbSchema.GetDataContext()
  
// Tables
let Addresses = db.Address
type Address = dbSchema.ServiceTypes.Address

let AddressTypes = db.AddressType
type AddressType = dbSchema.ServiceTypes.AddressType

let Employees = db.Employee
type Employee = dbSchema.ServiceTypes.Employee

let EmployeeTasks = db.EmployeeTask
type EmployeeTask = dbSchema.ServiceTypes.EmployeeTask

let OnCalls = db.OnCall
type OnCall = dbSchema.ServiceTypes.OnCall

let PhoneNumbers = db.PhoneNumber
type PhoneNumber = dbSchema.ServiceTypes.PhoneNumber

let PhoneTypes = db.PhoneType
type PhoneType = dbSchema.ServiceTypes.PhoneType

let Shifts = db.Shift
type Shift = dbSchema.ServiceTypes.Shift

let Tasks = db.Task
type Task = dbSchema.ServiceTypes.Task

let Teams = db.Team
type Team = dbSchema.ServiceTypes.Team

let AddEmployee(userName, displayName, jobTitle, company, emailAddress, startDate) =
  let e = new Employee(UserName = userName, DisplayName = displayName, 
                        JobTitle = jobTitle, Company = company, 
                        EmailAddress = emailAddress, StartDate = startDate)

  Employees.InsertOnSubmit(e)
  Employees.Context.SubmitChanges()

let AddPhoneNumber(employee : Employee, phoneType : PhoneType, number : string) =
  let phoneNumber = new PhoneNumber(Employee = employee, PhoneType = phoneType, Number = number)
  
  employee.PhoneNumber.Add(phoneNumber)
  Employees.Context.SubmitChanges()

let BootstrapPhoneTypes() =
  let phoneTypes = [| new PhoneType(Name = "Work");
                      new PhoneType(Name = "Cell");
                      new PhoneType(Name = "Home");
                      new PhoneType(Name = "Other") |]

  PhoneTypes.InsertAllOnSubmit(phoneTypes)
  PhoneTypes.Context.SubmitChanges()

let GetPhoneType(name) =
  query {
    for p in PhoneTypes do
       where (p.Name = name)
       select p
       exactlyOne
  }

let BootstrapTeams() =
  let teams = [| new Team(Name = "Ops", Description = "Network Operations");
                 new Team(Name = "Eng", Description = "Engineering");
                 new Team(Name = "IA", Description = "Information Assurance") |]

  Teams.InsertAllOnSubmit(teams)
  Teams.Context.SubmitChanges()

let GetTeam(name) =
  query {
    for t in Teams do
       where (t.Name = name)
       select t
       exactlyOne
  }

// Bootstrap the db quick and dirty
let BootstrapEmployees() = 

  BootstrapPhoneTypes()
  BootstrapTeams()

  for e in EmployeeData.GetSamples() do
    Console.WriteLine("Adding: {0}", e.DisplayName)
    let emp = new Employee()
    emp.UserName <- e.UserName
    emp.DisplayName <- e.DisplayName
    emp.JobTitle <- e.JobTitle
    emp.Company <- e.Company
    emp.EmailAddress <- e.EmailAddress
    emp.StartDate <- e.StartDate
    
    Employees.InsertOnSubmit(emp)
    Employees.Context.SubmitChanges()

    e.PhoneNumbers
    |> Seq.iter (fun pn -> emp.PhoneNumber.Add(new PhoneNumber(PhoneTypeID = GetPhoneType(pn.Type).Id, Number = pn.Number)))

    e.Shifts
    |> Seq.iter (fun s -> emp.Shift.Add(new Shift(StartTime = s.StartTime.TimeOfDay, EndTime = s.EndTime.TimeOfDay, Day = s.Day)))

    emp.Team <- GetTeam(e.Team.Name)

    Employees.Context.SubmitChanges()

BootstrapEmployees()