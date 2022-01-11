### Frame for script found from https://social.technet.microsoft.com 

#Brings in csv with computer names
$computerList = Import-Csv .\computerlist.csv 

#Grabs credentials so you don't have to input them for each computer.
$UserInfo = Get-Credential

foreach($computer in $computerList)  {

    try{

        Rename-Computer -ComputerName $computer.OldName -NewName $computer.NewName -DomainCredential $UserInfo -Force -PassThru -Restart

        #Sets status to updated if successful.
        $computer.status = "Updated";

     }

 
    catch{

        #Sets status to failed so no computers get left unnamed.
        $computer.status = "Failed";

    }

}
#Captures timestamp of when the rename was attempted.
$computer.timestamp = Get-Date -Format "MM/yyyy HH:mm"

#updates all of the columns in computerlist.csv.
$computerList | Export-Csv .\computerlist.csv -NoTypeInformation -Force
