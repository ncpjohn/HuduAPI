function Get-HuduAssetLayouts {
	Param (
		[String]$name ='',
		[String]$layoutid=''
	)
	
	if ($layoutid) {
		$AssetLayout = Invoke-HuduRequest -Method get -Resource "/api/v1/asset_layouts/$($layoutid)"
		return $AssetLayout.asset_layout
	} else {
		
		$i = 1;
		$AllAssetLayouts = do {
		$AssetLayouts = Invoke-HuduRequest -Method get -Resource "/api/v1/asset_layouts?page=$i&page_size=1000"
		$i++
		$AssetLayouts.Asset_Layouts
		} while ($AssetLayouts.asset_layouts.count % 1000 -eq 0 -and $AssetLayouts.asset_layouts.count -ne 0)
		
		
		if ($name) {
		$AllAssetLayouts = $AllAssetLayouts | where-object {$_.name -eq $name}
		}
		
		return $AllAssetLayouts
	}
}