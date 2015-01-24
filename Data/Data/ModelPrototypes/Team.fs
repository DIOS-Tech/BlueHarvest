

namespace Data
open System


[<CLIMutable>]
type Team = {name: string; description: string; manager: virtual Employee}