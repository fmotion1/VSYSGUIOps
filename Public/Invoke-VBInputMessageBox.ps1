function Invoke-VBInputMessageBox {
    <#
    .SYNOPSIS
        Invokes a simple Visual Basic InputBox.
    .DESCRIPTION
        Displays a prompt in a dialog box, waits for the
        user to input text or click a button, and then
        returns a string containing the contents of the
        text box.
    .RETURNS
        [System.String]
        The value of the input box. If the
        user clicks Cancel, a zero-length string is
        returned.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false)]
        [string]
        $Title = "Enter a value",

        [Parameter(Mandatory=$false)]
        [string]
        $Message = "Please enter a valid value.",

        [Parameter(Mandatory = $false)]
        [string]
        $DefaultResponse = ""

    )

    [System.Windows.Forms.Application]::EnableVisualStyles()

    if([String]::IsNullOrEmpty($DefaultResponse)){
        $ans = [Microsoft.VisualBasic.Interaction]::InputBox($Message, $Title)
    }else{
        $ans = [Microsoft.VisualBasic.Interaction]::InputBox($Message, $Title, $DefaultResponse)
    }

    return $ans

}