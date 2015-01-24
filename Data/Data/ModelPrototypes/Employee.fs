

namespace Data
open System

[<CLIMutable>]
type Employee = { uniqueUserName : string; displayName: string; jobTitle: string; team : virtual Team; manager : virtual Employee}

