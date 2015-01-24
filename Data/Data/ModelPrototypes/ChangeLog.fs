

namespace Data
open System

[<CLIMutable>]
type ChangeEntry = { changingEmployee: virtual Employee; changing_time: datetime; oldValue: String; newValue: String; entityChanged: virtual object}
