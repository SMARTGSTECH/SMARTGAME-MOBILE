const String imageAssetRoot = "assets/";

//svg assets
final String bnblogo = _getImagePath("svg/bnb_logo.svg");
final String ethlogo = _getImagePath("svg/base.svg");
final String usdtlogo = _getImagePath("svg/usdt_logo.svg");
final String sollogo = _getImagePath("svg/sol_logo.svg");
final String tonlogo = _getImagePath("svg/ton_logo.svg");

//png assetsPath

final String logo = _getImagePath("png/logoo.jpg");

//abi assetsPath
final String bscTokenAbi = _getImagePath("abis/bsc_token_contract.json");
final String baseTokenAbi = _getImagePath("abis/base_token_contract.json");

String _getImagePath(String imageName) => imageAssetRoot + imageName;
