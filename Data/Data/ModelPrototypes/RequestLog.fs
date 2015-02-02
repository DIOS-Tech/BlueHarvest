

namespace BlueHarvest
open System

[<CLIMutable>]
type RequestEntry = { changingEmployee: virtual Employee; changing_time: datetime; request: virtual Request}