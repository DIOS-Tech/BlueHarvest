

namespace BlueHarvest
open System

[<CLIMutable>]
type Shift = { startTime: time; endTime: time; day: int; employee: virtual Employee}
