#### Screenfetch for powershell
#### Author Julian Chow


Function Screenfetch($distro)
{
    $AsciiArt = "";

    if (-not $distro) 
    {
        $AsciiArt = . Get-WindowsArt;
    }

    if (([string]::Compare($distro, "mac", $true) -eq 0) -or 
        ([string]::Compare($distro, "macOS", $true) -eq 0) -or 
        ([string]::Compare($distro, "osx", $true) -eq 0)) {
            
        $AsciiArt = . Get-MacArt;
    }
    elseif ([string]::Compare($distro, "winold", $true) -eq 0) 
    {
        $AsciiArt = . Get-OldWindowsArt;
    }
    else 
    {
        $AsciiArt = . Get-WindowsArt;
    }

    $SystemInfoCollection = . Get-SystemSpecifications;
    $LineToTitleMappings = . Get-LineToTitleMappings;

    $lines = If ( $SystemInfoCollection.Count -gt $AsciiArt.Count ) { $SystemInfoCollection.Count } else { $AsciiArt.Count }

    # Space on top
    Write-Host "";

    # Iterate over all lines from the SystemInfoCollection to display all information
    for ($line = 0; $line -lt $lines; $line++) 
    {
        if (($AsciiArt[$line].Length) -eq 0)
        {
            # Write some whitespaces to sync the left spacing with the asciiart.
            Write-Host "                                            " -f Cyan -NoNewline;
        }
        else
        {
            Write-Host "  " -NoNewline;
            Write-Host $AsciiArt[$line] -f Cyan -NoNewline;
            Write-Host "  " -NoNewline;
        }
        Write-Host $LineToTitleMappings[$line] -f Red -NoNewline;

        if ($line -eq 0) 
        {
            Write-Host $SystemInfoCollection[$line] -f Red;
        }

        elseif ($SystemInfoCollection[$line] -like '*:*') 
        {
            $Seperator = ":";
            $Splitted = $SystemInfoCollection[$line].Split($seperator);

            $Title = $Splitted[0] + $Seperator;
            $Content = $Splitted[1];

            Write-Host $Title -f Red -NoNewline;
            Write-Host $Content;
        }
        else 
        {
            Write-Host $SystemInfoCollection[$line];            
        }
    }
    # Space on bottom
    Write-Host "";
}

