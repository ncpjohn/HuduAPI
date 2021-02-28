function Set-HuduAsset {
	Param (
		[Parameter(Mandatory=$true)]
		[String]$name ='',
		[Parameter(Mandatory=$true)]
		[Int]$company_id='',
		[Parameter(Mandatory=$true)]
		[Int]$asset_layout_id='',
		[Parameter(Mandatory=$true)]
		[Array]$fields='',
		[Parameter(Mandatory=$true)]
		[Int]$asset_id='',
		[Parameter(Mandatory=$false)]
		[String]$serial =''
	)
	

	$asset = @{asset = @{}}
	
	$asset.asset.add('name',$name)
	$asset.asset.add('asset_layout_id',$asset_layout_id)
	$asset.asset.add('custom_fields',$fields)
	if($serial){
		$asset.asset.add('primary_serial', $serial)
	}
	
	$json = $asset | convertto-json -Depth 10
	
	$response = Invoke-HuduRequest -Method put -Resource "/api/v1/companies/$company_id/assets/$asset_id" -body $json
	
	$response
	
	
}