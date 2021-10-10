$directory = Get-ChildItem .\
foreach ($item in $directory) {
  Get-Acl $item
}