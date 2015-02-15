
// This code is for F# Interactive. 
// This is a sandbox to play with various things.

#r "System.dll"
#r "System.Data.Linq"
#r "FSharp.Data.TypeProviders.dll"

open System
open System.Data
open System.Data.Linq
open FSharp.Data
open Microsoft.FSharp.Data.TypeProviders
open Microsoft.FSharp.Linq

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

//let NewShift(startTime, endTime, day) =
//  let shift = new Shift(StartTime = startTime, EndTime = endTime, Day = day)
//
//  Shifts.InsertOnSubmit(shift)
//  Shifts.Context.SubmitChanges()

//////////////////////
// JSON STUFF BELOW //
//////////////////////

#r "../packages/FSharp.Data.2.1.1/lib/net40/FSharp.Data.dll"

//open System
open FSharp.Data

type EmployeeData = JsonProvider<"../../Database/data.json">

EmployeeData.GetSamples()
//|> Seq.iter (fun e -> AddEmployee(e.UserName, e.DisplayName, e.JobTitle, e.Company, e.EmailAddress, e.StartDate))
|> Seq.map(fun e -> e.DisplayName)
|> Seq.toList

EmployeeData.GetSamples().Length

EmployeeData.GetSamples()
|> Seq.map(fun x -> x.Team)
|> Seq.toList

/////////////////
// OTHER STUFF //
/////////////////

//let workPhoneType = GetPhoneType("Work")

let firstEmp = EmployeeData.GetSamples() |> Seq.head

let emp = new Employee()
emp.UserName <- firstEmp.UserName
emp.DisplayName <- firstEmp.DisplayName
emp.JobTitle <- firstEmp.JobTitle
emp.Company <- firstEmp.Company
emp.EmailAddress <- firstEmp.EmailAddress
emp.StartDate <- firstEmp.StartDate

Employees.InsertOnSubmit(emp)
Employees.Context.SubmitChanges()

firstEmp.PhoneNumbers
|> Seq.iter (fun pn -> emp.PhoneNumber.Add(new PhoneNumber(PhoneTypeID = GetPhoneType(pn.Type).Id, Number = pn.Number)))

Employees.Context.SubmitChanges()

firstEmp.Shifts
|> Seq.iter (fun s -> emp.Shift.Add(new Shift(StartTime = s.StartTime.TimeOfDay, EndTime = s.EndTime.TimeOfDay, Day = s.Day)))

Employees.Context.SubmitChanges()

emp.Team <- GetTeam(firstEmp.Team.Name)

Employees.Context.SubmitChanges()

emp
