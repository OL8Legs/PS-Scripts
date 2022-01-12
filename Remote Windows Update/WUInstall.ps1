$ModuleName = "PSWindowsUpdate"

# Installs the module and checks/installs Nuget on the system
Try {

    $null = Get-InstalledModule $ModuleName -ErrorAction Stop

} Catch {

    if ( -not ( Get-PackageProvider -ListAvailable | Where-Object Name -eq "Nuget" ) ) {

        $null = Install-PackageProvider "Nuget" -Force

    }

    $null = Install-Module $ModuleName -Force

}

# Imports the module to run the cmdlet

$null = Import-Module $ModuleName -Force

# If you don't assign the cmdlet to a variable it acts super weird.

$IWU = Install-WindowsUpdate -AcceptAll
