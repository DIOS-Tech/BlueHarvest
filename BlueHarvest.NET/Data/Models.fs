namespace Data

open System
open System.Collections.Generic

module Models = 

  // Inclusion of these here is debatable. These are either going to be used
  // as view models or data models.

  //FIXME: These need some serious love! Somebody take a look at these and
  // make sure they are sane!

  [<CLIMutable>]
  type Employee = 
    { UniqueUserName : string
      DisplayName: string
      JobTitle: string
      Team : Team
      Manager : Employee }

  and Team = 
    { Name : String
      Description : String
      Manager : Employee }

  [<CLIMutable>]
  type ChangeEntry = 
    { ChangingEmployee : Employee
      ChangingTime : DateTime
      OldValue : String
      NewValue : String }

  [<CLIMutable>]
  type AccessEntry = 
    { Employee : Employee
      AccessTime : DateTime }

  [<CLIMutable>]
  type Shift = 
    { StartTime : DateTime
      EndTime : DateTime
      Day : int
      Employee : Employee }

  [<CLIMutable>]
  type Request = 
    { Employee : Employee
      StartDate : DateTime 
      EndDate : DateTime
      Notes : string }

  [<CLIMutable>]
  type RequestEntry = 
    { ChangingEmployee : Employee
      ChangingTime : DateTime
      Request : Request }

  // need to enforce phone numbers here
  // need to build an enum to handle the phoneType
  [<CLIMutable>]
  type PhoneNumber = 
    { PhoneNumber : string
      PhoneType : int
      Employee : Employee }

  [<CLIMutable>]
  type OnCallEntry = 
    { Employee : Employee
      ShiftStart : DateTime
      ShiftFinish : DateTime }

