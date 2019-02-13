# Define UCS connection details
$ucsSysName = "cld3-fi1.srv.hcvlny.cv.net"
$ucsUserName = "admin"
$ucsPassword = "ciscoUCS123"




# The UCSM connection requires a PSCredential to login, so we must convert our plain text password to make an object
$ucsPassword = ConvertTo-SecureString -String $ucsPassword -AsPlainText -Force
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $ucsUserName, $ucsPassword

# Create connection to UCS system
$ucsConnection = Connect-Ucs $ucsSysName -Credential $cred
#Get-UcsChassisStats 
#Get-UCSCmdletMeta -Noun VLAN -Tree
#ConvertTo-UcsCmdlet
#Get-Command –Module CicsoUCSPS
#Get-UcsLsbootSanImage
#Get-UcsLsbootStorage
#Get-UcsLsbootSanImagePath
Get-UcsServiceProfile -Type instance
#Get-UcsIpPool