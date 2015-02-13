namespace Data

open System
open System.Collections.Generic

module Models = 
  
  [<CLIMutable>]
  type Team = 
    { ID : int
      Name : string
      Description : string }

  [<CLIMutable>]
  type Employee = 
    { ID : int
      Team : Team
      UserName : string
      Password : string // This will be encrypted if used but since we will be
                        // using ASP.NET Identity as it stands we won't have to
                        // manage this. We'll leave this in here though in case
                        // we want to dump ASP.NET Identity and it's complexity
                        // later on...
      DisplayName : string 
      JobTitle : string
      Company : string
      EmailAddress : string
      StartDate : DateTime
      EndDate : DateTime
      IsManager : bool
      Deactivated : bool }
   
  [<CLIMutable>]
  type AddressType = 
    { ID : int
      Name : string }

  [<CLIMutable>]
  type Address = 
    { ID : int
      AddressType : AddressType
      Employee : Employee
      StreetAddress : string
      StreetAddressUnit : string
      City : string
      State : string
      ZipCode : int }

  [<CLIMutable>]
  type Task =
    { ID : int
      Name : string
      Description : string
      [<DefaultValue>] 
      StartDate : Nullable<DateTime>
      DueDate : DateTime
      [<DefaultValue>] 
      EndDate : Nullable<DateTime>
      Notes : string }

  [<CLIMutable>]
  type EmployeeTask =
    { ID : int
      Employee : Employee
      Task : Task }

  [<CLIMutable>]
  type Shift = 
    { ID : int
      StartTime : DateTime
      EndTime : DateTime
      Day : int
      Employee : Employee }

  [<CLIMutable>]
  type VacationRequest = 
    { Employee : Employee
      StartDate : DateTime 
      EndDate : DateTime
      Notes : string }

  [<CLIMutable>]
  type PhoneType =
    { ID : int
      Name : string }

  [<CLIMutable>]
  type PhoneNumber = 
    { PhoneNumber : string
      PhoneType : PhoneType
      Employee : Employee }

  [<CLIMutable>]
  type OnCallEntry = 
    { Employee : Employee
      ShiftStart : DateTime
      ShiftFinish : DateTime }