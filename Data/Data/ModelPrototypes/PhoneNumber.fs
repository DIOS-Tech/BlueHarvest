

namespace Data
open System

// need to enforce phone numbers here
// need to build an enum to handle the phoneType
type PhoneNumber = { phone_number: string; phoneType: int; employee: virtual Employee }