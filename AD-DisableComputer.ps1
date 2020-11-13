function Disable-Computer {
    <#
    .SYNOPSIS
    Disables a computer.
    .DESCRIPTION
    Disables a computer or group of computers by passing host names or computer AD objects to this function. 
    .PARAMETER Name
    This is the host name of the computer that will be disable.
    .INPUTS
    Computer AD objects can be passed to this function from the pipeline.
    .OUTPUTS
    An array of computer AD objects. One for each computer that this function disables.
    .NOTES
    .EXAMPLE 
    Disable-Computer -Name "Computer1"
    Disables the computer named "Computer1" in Active Directory.
    .EXAMPLE
    "Computer1","Computer2" | Disable-Computer
    Disables computers Computer1 and Computer2 in Active Directory.
    .EXAMPLE
    Get-ADComputer Computer1 | Disable-Computer
    Disables Computer1 in Active Directory.
    .LINK
    Yusuf TEZCAN
    linkedin.com/in/ysftzcn
    github.com/ysftzcn
    #>

    [cmdletbinding(SupportsShouldProcess)]
    param(
        [parameter(ValueFromPipeline = $True, ValueFromPipelineByPropertyName = $true, Mandatory = $True)]
        [Alias('ComputerName')]
        [string]$Name
    )

    begin {
        $disabledComputers = @()
    }

    process {
        $computer = Get-ADComputer $Name
        $computer | Disable-ADAccount

        #Updates computer object to show disabled status.
        Start-Sleep -Seconds 1
        $computer = Get-ADComputer $Name
        $disabledComputers += $computer
    }

    end {
        return $disabledComputers
    }
}