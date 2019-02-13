#Configure SNMP
$i = 8

$expression = "perl ""C:\Program Files (x86)\VMware\VMware vSphere CLI\bin\vicfg-snmp.pl"" --server cld3-c11-b$i.srv.hcvlny.cv.net --username root --password r00t123 --show"
Invoke-expression $expression
$expression = "perl ""C:\Program Files (x86)\VMware\VMware vSphere CLI\bin\vicfg-snmp.pl"" --server cld3-c11-b$i.srv.hcvlny.cv.net --username root --password r00t123 -c 'public,vmware'"
Invoke-expression $expression
$expression = "perl ""C:\Program Files (x86)\VMware\VMware vSphere CLI\bin\vicfg-snmp.pl"" --server cld3-c11-b$i.srv.hcvlny.cv.net --username root --password r00t123 -t '172.16.30.111@162/public,172.16.30.111@162/vmware'"
Invoke-expression $expression
 $expression = "perl ""C:\Program Files (x86)\VMware\VMware vSphere CLI\bin\vicfg-snmp.pl"" --server cld3-c11-b$i.srv.hcvlny.cv.net --username root --password r00t123 -p 161"
Invoke-expression $expression
$expression = "perl ""C:\Program Files (x86)\VMware\VMware vSphere CLI\bin\vicfg-snmp.pl"" --server cld3-c11-b$i.srv.hcvlny.cv.net --username root --password r00t123 --enable"
Invoke-expression $expression
$expression = "perl ""C:\Program Files (x86)\VMware\VMware vSphere CLI\bin\vicfg-snmp.pl"" --server cld3-c11-b$i.srv.hcvlny.cv.net --username root --password r00t123 --show"
Invoke-expression $expression

