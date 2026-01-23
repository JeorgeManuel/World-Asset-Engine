extends TerminalApplication

func _init():
	name = "nft"
	description = "Fetch NFT data from Alchemy API"

func run(terminal : Terminal, params : Array):
	if params.is_empty():
		terminal.add_to_log("Error: Please provide your Alchemy API key")
		terminal.add_to_log("Usage: nft <api_key>")
		return
	
	var api_key = params[0]
	var base_url = "https://eth-mainnet.g.alchemy.com/nft/v3/%s" % api_key
	
	terminal.add_to_log("Fetching NFTs for address: vitalik.eth")
	terminal.add_to_log("...")
	
	# Create HTTP request for getNFTsForOwner
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(_on_nfts_response.bind(terminal, base_url, api_key))
	
	var owner_addr = "vitalik.eth"
	var url = "%s/getNFTsForOwner?owner=%s&pageSize=5" % [base_url, owner_addr]
	http_request.request(url, [], HTTPClient.METHOD_GET)

func _on_nfts_response(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray, terminal: Terminal, base_url: String, api_key: String):
	if response_code != 200:
		terminal.add_to_log("Error: Failed to fetch NFTs (HTTP %d)" % response_code)
		return
	
	var json = JSON.new()
	var nfts_data = json.parse_string(body.get_string_from_utf8())
	
	if nfts_data == null:
		terminal.add_to_log("Error: Failed to parse NFT response")
		return
	
	terminal.add_to_log("Number of NFTs found: %d" % nfts_data.get("totalCount", 0))
	terminal.add_to_log("...")
	
	# Print contract address and tokenId for each NFT
	var owned_nfts = nfts_data.get("ownedNfts", [])
	for nft in owned_nfts:
		terminal.add_to_log("===")
		var contract = nft.get("contract", {})
		terminal.add_to_log("Contract address: %s" % contract.get("address", "N/A"))
		terminal.add_to_log("Token ID: %s" % nft.get("tokenId", "N/A"))
	
	terminal.add_to_log("===")
	terminal.add_to_log("Fetching metadata for a Crypto Coven NFT...")
	
	# Fetch metadata for a particular NFT
	var contract_address = "0x5180db8F5c931aaE63c74266b211F580155ecac8"
	var token_id = "1590"
	
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(_on_metadata_response.bind(terminal, base_url))
	
	var metadata_url = "%s/getNFTMetadata?contractAddress=%s&tokenId=%s" % [base_url, contract_address, token_id]
	http_request.request(metadata_url, [], HTTPClient.METHOD_GET)

func _on_metadata_response(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray, terminal: Terminal, base_url: String):
	if response_code != 200:
		terminal.add_to_log("Error: Failed to fetch metadata (HTTP %d)" % response_code)
		return
	
	var json = JSON.new()
	var metadata = json.parse_string(body.get_string_from_utf8())
	
	if metadata == null:
		terminal.add_to_log("Error: Failed to parse metadata response")
		return
	
	# Print some commonly used fields
	var name_field = metadata.get("name", metadata.get("title", "N/A"))
	terminal.add_to_log("NFT name: %s" % name_field)
	terminal.add_to_log("Token type: %s" % metadata.get("tokenType", "N/A"))
	terminal.add_to_log("TokenUri: %s" % metadata.get("tokenUri", "N/A"))
	
	var image_url = "N/A"
	if metadata.has("image") and metadata["image"].has("originalUrl"):
		image_url = metadata["image"]["originalUrl"]
	elif metadata.has("rawMetadata") and metadata["rawMetadata"].has("image"):
		image_url = metadata["rawMetadata"]["image"]
	
	terminal.add_to_log("Image URL: %s" % image_url)
	terminal.add_to_log("Time last updated: %s" % metadata.get("timeLastUpdated", "N/A"))
	terminal.add_to_log("===")
