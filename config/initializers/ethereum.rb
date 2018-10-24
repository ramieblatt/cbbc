require 'eth'

ETHEREUM_CLIENT = Ethereum::HttpClient.new(BLOCKCHAIN_URL)
key = Eth::Key.new(priv: Rails.application.secrets.contract_owner_private_key)
ETHEREUM_CLIENT.default_account = key.address
ETHEREUM_CONTRACT = Ethereum::Contract.create(name: "Cbbc", truffle: { paths: [ TRUFFLE_PATH ] }, client: ETHEREUM_CLIENT, address: Rails.application.secrets.cbbc_contract_address)
ETHEREUM_CONTRACT.key = key

# require 'eth'

# TRUFFLE_PATH = '/Users/ramie/cbbc_smart_contracts/cbbc-zos'
# URL = 'HTTP://127.0.0.1:7545' #Ganache
# #URL = "https://rinkeby.infura.io/v3/xxxx" #Infura

# # Reading contents of your key file
# # json = File.read('/path/to/my/key/file')
# # Decrypting key with 'eth' gem
# # key = Eth::Key.decrypt(json, 'MyP@$$w0rD')

# client = Ethereum::HttpClient.new(URL)

# contract = Ethereum::Contract.create(name: "Cbbc", truffle: { paths: [ TRUFFLE_PATH ] }, client: client, address: '0xbdcce0ff3d01dd65bcbb40fc34546a165e238cb5')





# key = Eth::Key.new(priv: config.secrets.contract_owner_private_key)
# ETHEREUM_CLIENT.default_account = key.address
# contract = Ethereum::Contract.create(...)
# contract.key = key
