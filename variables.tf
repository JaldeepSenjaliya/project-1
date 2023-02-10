variable "prefix" {
  default = "project-1"
}

variable "username" {
    type = list(string)
    default = ["Snehal", "Jaspal", "Afsah", "Harsimranjit"]
}

variable "bucket_list" {
    type = list(string)
    default = [ "bucket1", "bucket2"]
}