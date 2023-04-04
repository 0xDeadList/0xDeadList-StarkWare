### Project name

0xDeadList

### Project description

0xDeadList project maintains a leaked address list for the public good.

0xDeadList collects the "dead" addresses whose leaked private keys are leaked (known by others). Users are able to bury wallets and get Burier NFTs for reporting leaked private keys that they own or they know. DApps are able to block those publicly accessible wallets with on/off-chain APIs.

### Why deploy 0xDeadList on StarkNet?

- **StarkNet supports the Stark-friendly elliptic curve.** The widely used Stark key in StarkNet is different from ETH public key and address used in EVM Compatible Blockchains. Consequently, it is appropriate to maintain a leaked Stark key list on StarkNet, enabling DApps built on StarkNet to protect the security of StarkNet's native Externally Owned Account (EOA).

- **StarkNet supports Elliptic Curve Operations natively, which enables DApps to integrate complicated Elliptic Curve logic more efficiently and securely.** 0xDeadList contract generates public key from private key. This requires Elliptic Curve operators, which are natively supported in StarkWare and are gas efficient. Previously, we [implemented the operators](https://github.com/0xDeadList/0xDeadList/blob/main/contracts/EllipticCurve.sol) through solidity, now we could only use the natively supported `ec_mul` op to achieve the same functionality. It is worth mentioning that supporting STARK Curve in other blockchains without the natively Elliptic Curve Operations is a nightmare, which makes StarkNet a solid choice.

### Why do we build 0xDeadList?

Once the private key of an EOA is leaked, the EOA owner will lose the exclusive right to access the EOA, which indicates this EOA is not secure anymore.

DApps should be aware of that ASAP to protect the real owners of these EOAs. For example, when one reports that her private key is leaked:

1. Multi-signature wallets (e.g., [Gnosis Safe](https://gnosis-safe.io/)) should handle urgent cases when some of the wallet's EOAs are leaked.
2. Web3 email providers (e.g., [MetaMail](https://metamail.ink/)) in which users log in with signatures of their EOAs should suspend access to emails of this EOA, preventing the emails stolen by hackers.
3. Electronic agreements based on EOA (e.g., [ETHSign](https://www.ethsign.xyz/)) should stop this EOA to sign new agreements. Because the new agreements may be signed by hackers.

0xDeadList maintains a leaked address list for the public good.

By rewarding the burier NFT, 0xDeadList encourages both users and hackers to report EOAs with lost private keys and stores the information of these leaked EOAs on chain. DApps projects can identify these insecure EOAs.

Generally speaking, once the private key of the to-be-buried address is uploaded, 0xDeadList will generate the public key of this private key. The private key of the buried address will be made public through event emitting, ensuring the leaked address is indeed leaked. Finally, 0xDeadList will reward the reporter with a burier NFT.


### Website

https://0xdeadlist.io/

### GitHub

https://github.com/0xDeadList

### Twitter

https://twitter.com/0xDeadList

### Deployed Contracts:

Starknet Goerli Testnet: https://testnet.starkscan.co/contract/0x017e3fe74b06ed2447c56d171339dbeab98507c1acff10bc7458cedd4d0c3b11

Starknet Mainnet: https://starkscan.co/contract/0x054c35e462a3d64e7567fa2fb717949da12260b936e2effa95aef1d9a58be737

### TODO

- Generate NFT SVG in ERC721 contract
- Add support for Account Abstraction.
