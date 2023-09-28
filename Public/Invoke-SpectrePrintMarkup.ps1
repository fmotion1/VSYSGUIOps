using namespace System.Management.Automation
using namespace System.Management.Automation.Language
using namespace System.Collections
using namespace System.Collections.Generic
using namespace Spectre.Console

function Invoke-SpectrePrintMarkup {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [String]
        $Message
    )

    process {
        [AnsiConsole]::MarkupLine($Message)
    }

}