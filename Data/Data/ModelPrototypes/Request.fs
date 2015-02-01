

namespace Data
open System

[<CLIMutable>]
type Request = { employee: virtual Employee; start_date: datetime; end_date: datetime; notes: string}