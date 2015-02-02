namespace BlueHarvest

open System
open System.Collections.Generic

[<CLIMutable>]
type AccessEntry = 
  {  employee: virtual Employee
     access_time: DateTime }