<#
.SYNOPSIS
Makes an API request to the specified Relativity endpoint.

.DESCRIPTION
Constructs and sends an API request to the given Relativity endpoint, using the specified HTTP method and request body.

.PARAMETER RelativityBusinessDomain
The business domain for which the API request is intended.

.PARAMETER RelativityApiEndpointExtended
The specific API endpoint (excluding the base) to which the request is to be made.

.PARAMETER RelativityApiHttpMethod
The HTTP method to use for the API request. Currently, only "Post" is supported.

.PARAMETER RelativityApiRequestBody
A hashtable containing the request body to be sent with the API request.

.NOTES
This function is internal and is the primary method for making API calls to the Relativity system.
#>
function Invoke-RelativityApiRequest
{
    Param
    (
        [Parameter(Mandatory = $true)]
        [ValidateSet("ARM")]
        [String] $RelativityBusinessDomain,
        [Parameter(Mandatory = $true)]
        [String] $RelativityApiEndpointExtended,
        [Parameter(Mandatory = $true)]
        [ValidateSet("Post")]
        [String] $RelativityApiHttpMethod,
        [Parameter(Mandatory = $true)]
        [Hashtable] $RelativityApiRequestBody
    )

    $RelativityApiEndpointBase = Get-RelativityApiEndpointBase -RelativityBusinessDomain $RelativityBusinessDomain
    $RelativityApiEndpoint = "$($RelativityApiEndpointBase)$($RelativityApiEndpointExtended)"

    $RelativityApiRequestHeader = Get-RelativityApiRequestHeader

    Invoke-RestMethod -Uri $RelativityApiEndpoint -Method $RelativityApiHttpMethod -Headers $RelativityApiRequestHeader -Body ($RelativityApiRequestBody | ConvertTo-Json -Depth 3) -ContentType "application/json"
}