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
  let Addresses = db.Addresses
  let AddressTypes = db.AddressTypes
  let Employees = db.Employees
  let EmployeeTasks = db.EmployeeTasks
  let OnCall = db.OnCall
  let PhoneNumbers = db.PhoneNumbers
  let PhoneTypes = db.PhoneTypes
  let Shifts = db.Shifts
  let Task = db.Task
  let Teams = db.Teams
  
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