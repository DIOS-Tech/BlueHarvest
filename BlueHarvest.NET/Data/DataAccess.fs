namespace BlueHarvest.DataAccess

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

  let Contacts = db.Contact
  type Contact = dbSchema.ServiceTypes.Contact

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

  let TimeEntries = db.TimeEntry
  type TimeEntry = dbSchema.ServiceTypes.TimeEntry

  let TimeTypes = db.TimeType
  type TimeType = dbSchema.ServiceTypes.TimeType

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
    
  let GetTimeTypeById(id) = 
    query {
      for t in TimeTypes do        
        where (t.Id = id)
        select t
        exactlyOneOrDefault
    }

  let AddTimeType(name, code) =
    let tt = new TimeType(Name = name, Code = code)
    TimeTypes.InsertOnSubmit(tt)
    db.DataContext.SubmitChanges()

  let UpdateTimeType(id, name, code) =
    let tt = GetTimeTypeById(id)
    
    if tt <> null then
      tt.Name <- name
      tt.Code <- code

      db.DataContext.SubmitChanges()

  let DeleteTimeType(id) =
    let tt = 
      query {
        for t in TimeTypes do        
          where (t.Id = id)
          select t
          exactlyOneOrDefault
      }

    if tt <> null then
      TimeTypes.DeleteOnSubmit(tt)
      db.DataContext.SubmitChanges()

  let GetTimeEntryById(id) =
    query {
      for t in TimeEntries do        
        where (t.Id = id)
        select t
        exactlyOneOrDefault
    }      

  let AddTimeEntry(employeeId, timeTypeId, startTime, endTime, notes) =
    let te = new TimeEntry(EmployeeID = employeeId, TimeTypeID = timeTypeId, StartTime = startTime, EndTime = endTime, Notes = notes)
    TimeEntries.InsertOnSubmit(te)
    db.DataContext.SubmitChanges()

  let UpdateTimeEntry(id, startTime, endTime, notes) =
    let te = GetTimeEntryById(id)

    if te <> null then
      te.StartTime <- startTime
      te.EndTime <- endTime
      te.Notes <- notes

      db.DataContext.SubmitChanges()

  let DeleteTimeEntry(id) =
    let te = 
      query {
        for t in TimeEntries do        
          where (t.Id = id)
          select t
          exactlyOneOrDefault
      }

    if te <> null then
      TimeEntries.DeleteOnSubmit(te)
      db.DataContext.SubmitChanges()

  let GetContactById(id) =
    query {
      for c in Contacts do        
        where (c.Id = id)
        select c
        exactlyOneOrDefault
    }

  let GetPhoneNumberById(id) =
    query {
      for p in PhoneNumbers do        
        where (p.Id = id)
        select p
        exactlyOneOrDefault
    }   

  let GetAddressById(id) =
    query {
      for a in Addresses do        
        where (a.Id = id)
        select a
        exactlyOneOrDefault
    }     

  // I'm cutting a corner here, we need a higher level function which is a little more
  // useful when it comes to the phone number and address. Instead of providing a way
  // to set that here I'm just going to assume it's already valid and we'll just provide
  // an id. This needs to be changed later.
  let AddContact(firstName, lastName, phoneNumberId, addressId) =
    // Make sure phoneNumberId and addressId is valid
    if GetPhoneNumberById(phoneNumberId) <> null 
       && GetAddressById(addressId) <> null then
      let c = new Contact(FirstName = firstName, LastName = lastName, PhoneNumberID = phoneNumberId, AddressID = addressId)
      Contacts.InsertOnSubmit(c)
      db.DataContext.SubmitChanges()
  
  let UpdateContact(id, firstName, lastName, phoneNumberId, addressId) =
    // Make sure phoneNumberId and addressId is valid
    if GetPhoneNumberById(phoneNumberId) <> null 
       && GetAddressById(addressId) <> null then

      let c = GetContactById(id)

      if c <> null then
        c.FirstName <- firstName
        c.LastName <- lastName
        c.AddressID <- addressId
        c.PhoneNumberID <- phoneNumberId

      db.DataContext.SubmitChanges()

  let DeleteContact(id) =
    let c = GetContactById(id)

    if c <> null then
      Contacts.DeleteOnSubmit(c)
      db.DataContext.SubmitChanges()