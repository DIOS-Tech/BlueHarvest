
// This code is for F# Interactive. This is a sandbox to play with various things.

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

