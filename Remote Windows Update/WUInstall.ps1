$ModuleName = "PSWindowsUpdate"

# Install the module if it is not already installed, then load it.
Try {

    $null = Get-InstalledModule $ModuleName -ErrorAction Stop

} Catch {

    if ( -not ( Get-PackageProvider -ListAvailable | Where-Object Name -eq "Nuget" ) ) {

        $null = Install-PackageProvider "Nuget" -Force

    }

    $null = Install-Module $ModuleName -Force

}

$null = Import-Module $ModuleName -Force

# The Collection object this cmdlet emits is really weird.
# We have to assign it to a variable to get it to work properly in a pipeline.

$IWU = Install-WindowsUpdate -AcceptAll