

namespace Data
open System

[<CLIMutable>]
type AccessEntry = { employee: virtual Employee; access_time: datetime}
