

Connect-VIServer -Server cld3-c4-b -User root -Password r00t123
#Removes CD Drive entirely
#$cd = Get-CDDrive -VM rfdnapp1   
#Remove-CDDrive -CD $cd

#Creates new cd drive device ( if not installed )
New-CDDrive -VM rfdnapp1
