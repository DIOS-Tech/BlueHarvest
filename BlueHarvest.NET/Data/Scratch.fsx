
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

let GetEmployees() =
    Employees |> Seq.toList

let GetEmployeeById(id) =
    query {
      for e in Employees do
      where (e.Id = id)
      select e
      exactlyOneOrDefault
    }    

let GetEmployeeByUsername(userName) =
    query {
      for e in Employees do
      where (e.UserName = userName)
      select e
      exactlyOneOrDefault
    }    

let AddEmployee(userName, lastName, firstName, displayName, jobTitle, company, emailAddress, startDate) =
  let e = new Employee(UserName = userName, LastName = lastName, FirstName = firstName, DisplayName = displayName, 
                        JobTitle = jobTitle, Company = company, 
                        EmailAddress = emailAddress, StartDate = startDate)

  Employees.InsertOnSubmit(e)
  db.DataContext.SubmitChanges()

let UpdateEmployee(employee:Employee) =   
   //FIXME: If we pass in a valid employee with a valid ID we shouldn't be
   //       looking the employee up in the DB.
   let e = GetEmployeeById(employee.Id)
   if e <> null then
    // I don't want to through an error if somebody passes in a null value for
    // a column that cannot be null. Let's just check for it and if the column
    // isn't null we'll update it.
    if e.LastName <> null then
      e.LastName <- employee.LastName
    if e.FirstName <> null then
      e.FirstName <- employee.FirstName
    if not (String.IsNullOrEmpty(e.UserName) && GetEmployeeByUsername(e.UserName) = null) then
      e.UserName <- employee.UserName
    if not (String.IsNullOrEmpty(e.DisplayName)) then
      e.DisplayName <- employee.DisplayName
    if not (String.IsNullOrEmpty(e.JobTitle)) then
      e.JobTitle <- employee.JobTitle
    if not (String.IsNullOrEmpty(e.Company)) then
      e.Company <- employee.Company
    if not (String.IsNullOrEmpty(e.EmailAddress)) then
      e.EmailAddress <- employee.EmailAddress
    
    e.StartDate <- employee.StartDate
    e.EndDate <- employee.EndDate 
    e.IsManager <- employee.IsManager
    e.Deactivated <- employee.Deactivated

    db.DataContext.SubmitChanges()

let AddPhoneNumber(employee : Employee, phoneType : PhoneType, number : string) =
  let phoneNumber = new PhoneNumber(Employee = employee, PhoneType = phoneType, Number = number)
  
  employee.PhoneNumber.Add(phoneNumber)
  db.DataContext.SubmitChanges()

let BootstrapPhoneTypes() =
  let phoneTypes = [| new PhoneType(Name = "Work");
                      new PhoneType(Name = "Cell");
                      new PhoneType(Name = "Home");
                      new PhoneType(Name = "Other") |]

  PhoneTypes.InsertAllOnSubmit(phoneTypes)
  db.DataContext.SubmitChanges()

let GetPhoneTypeById(id) =
  query {
    for p in PhoneTypes do
       where (p.Id = id)
       select p
       exactlyOneOrDefault
  }

let GetPhoneTypeByName(name) =
  query {
    for p in PhoneTypes do
       where (p.Name = name)
       select p
       exactlyOneOrDefault
  }

let GetEmployeePhoneById(id) =
  query {
    for p in PhoneNumbers do
       where (p.Id = id)
       select p
       exactlyOneOrDefault
  }

let UpdatePhoneTypeByName(oldName, newName) =  
  let phoneType = GetPhoneTypeByName(oldName)
  if phoneType <> null then
    phoneType.Name <- newName
    db.DataContext.SubmitChanges()

let UpdatePhoneNumberByEmployeeId(employeeId, phoneId, phoneTypeId, number) =
  let emp = GetEmployeeById(employeeId)
  let pt = GetPhoneTypeById(phoneTypeId)
  if not (emp = null && pt = null) then
    let phoneNumber = 
      query {
        for pn in emp.PhoneNumber do
        where (pn.Id = phoneId)
        select pn
        exactlyOneOrDefault
      }

    if phoneNumber <> null then
      phoneNumber.Number <- number
      db.DataContext.SubmitChanges()

let GetAddressTypeByName(name) =
  query {
    for a in AddressTypes do
       where (a.Name = name)
       select a
       exactlyOneOrDefault
  }

let UpdateAddressTypeByName(oldName, newName) =
  let address = GetAddressTypeByName(oldName)
  if address <> null then
    address.Name <- newName
    db.DataContext.SubmitChanges()

let GetTaskById(id) =
  query {
    for t in Tasks do
       where (t.Id = id)
       select t
       exactlyOneOrDefault
  } 

//FIXME: Once the basic data access layer in place some fixes to the
//       Task table needs to take place. Instead of having an EmployeeTasks
//       table to track what tasks are assigned to an employee we just need
//       to have an employee ID column in this table.
let AddTask(name, description, startDate, dueDate, endDate, notes) =
  let task = new Task(Name = name, Description = description, StartDate = startDate, DueDate = dueDate, EndDate = endDate, Notes = notes)  

  Tasks.InsertOnSubmit(task)
  db.DataContext.SubmitChanges()

let UpdateTask(task:Task) =
  let t = GetTaskById(task.Id)
  if t <> null then
    if not (String.IsNullOrEmpty(task.Name)) then
      t.Name <- task.Name
    if not (String.IsNullOrEmpty(task.Description)) then
      t.Description <- task.Description
    
    t.StartDate <- task.StartDate
    t.DueDate <- task.DueDate
    t.EndDate <- task.EndDate
    t.Notes <- task.Notes

    db.DataContext.SubmitChanges()

let AssignTask(employeeId, taskId) =
  let emp = GetEmployeeById(employeeId)
  let task = GetTaskById(taskId)

  if not (emp = null && task = null) then
    let et = new EmployeeTask(EmployeeID = emp.Id, TaskID = taskId)
    EmployeeTasks.InsertOnSubmit(et)
    db.DataContext.SubmitChanges()

// Bootstrap helpers

let BootstrapTeams() =
  let teams = [| new Team(Name = "Ops", Description = "Network Operations");
                 new Team(Name = "Eng", Description = "Engineering");
                 new Team(Name = "IA", Description = "Information Assurance") |]

  Teams.InsertAllOnSubmit(teams)
  Teams.Context.SubmitChanges()

let BootstrapAddressTypes() =
  let addressTypes = [| new AddressType(Name = "Home");
                        new AddressType(Name = "Work");
                        new AddressType(Name = "Other"); |]

  AddressTypes.InsertAllOnSubmit(addressTypes)
  db.DataContext.SubmitChanges()

let GetTeam(name) =
  query {
    for t in Teams do
       where (t.Name = name)
       select t
       exactlyOneOrDefault
  }

// Bootstrap the db quick and dirty
let BootstrapEmployees() = 

  BootstrapAddressTypes()
  BootstrapPhoneTypes()
  BootstrapTeams()

  for e in EmployeeData.GetSamples() do
    Console.WriteLine("Adding: {0}", e.DisplayName)
    let emp = new Employee()
    emp.LastName <- e.LastName
    emp.FirstName <- e.FirstName
    emp.UserName <- e.UserName
    emp.DisplayName <- e.DisplayName
    emp.JobTitle <- e.JobTitle
    emp.Company <- e.Company
    emp.EmailAddress <- e.EmailAddress
    emp.StartDate <- e.StartDate
    
    Employees.InsertOnSubmit(emp)
    Employees.Context.SubmitChanges()

    e.PhoneNumbers
    |> Seq.iter (fun pn -> emp.PhoneNumber.Add(new PhoneNumber(PhoneTypeID = GetPhoneTypeByName(pn.Type).Id, Number = pn.Number)))

    e.Shifts
    |> Seq.iter (fun s -> emp.Shift.Add(new Shift(StartTime = s.StartTime.TimeOfDay, EndTime = s.EndTime.TimeOfDay, Day = s.Day)))

    emp.Team <- GetTeam(e.Team.Name)

    Employees.Context.SubmitChanges()

BootstrapEmployees()

// scratch below....

//EmployeeData.GetSamples()
//
//EmployeeData.GetSamples()
//|> Seq.map(fun x -> [ x.DisplayName; x.JobTitle ])
//|> Seq.toList
//
//query { 
//    for e in EmployeeData.GetSamples() do
//    where (e.Team.Name = "Ops")
//    select [ e.DisplayName; e.JobTitle ]
//} |> Seq.toList
//
//type NameAndShifts = 
//  { DisplayName : string
//    Shifts : Array }
//
//EmployeeData.GetSamples()
//|> Seq.map(fun x -> { DisplayName = x.DisplayName; Shifts = x.Shifts })
//|> Seq.take 10
//|> Seq.toList