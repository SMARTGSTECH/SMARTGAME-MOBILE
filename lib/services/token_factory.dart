import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class TokenFactory{

  Future<Web3Client> initWebClient(rpcUrl)async {
    var httpClient = Client();
    var client = Web3Client(rpcUrl, httpClient);
    return client;
  }

  Future<EthPrivateKey> getCredentials(String privateKey)async{
    final credentials = EthPrivateKey.fromHex("$privateKey");//0x
    return credentials;
  }

  Future<DeployedContract> intContract(String abiCode,contractAddress,String name)async{
    final contract = DeployedContract(ContractAbi.fromJson(abiCode, name), EthereumAddress.fromHex(contractAddress));
    return contract;
  }
}