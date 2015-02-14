module DataAccess

open System
open System.Data
open System.Data.Linq
open Microsoft.FSharp.Data.TypeProviders
open Microsoft.FSharp.Linq

module SQL =

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
  type PhoneType = dbSchema.ServiceTypes.PhoneNumber

  let Shifts = db.Shift
  type Shift = dbSchema.ServiceTypes.Shift

  let Tasks = db.Task
  type Task = dbSchema.ServiceTypes.Task

  let Teams = db.Team
  type Team = dbSchema.ServiceTypes.Team

  // Views
  let ShiftView = db.ShiftView
  let ManagerView = db.ManagerView
  let OnCallView = db.OnCallView

  let GetEmployees() =
    Employees |> Seq.toList

  let GetEmployeeById(id) =
     query {
       for e in Employees do
       where (e.Id = id)
       select e
       exactlyOne
     }

  let AddNewEmployee() =
    ()