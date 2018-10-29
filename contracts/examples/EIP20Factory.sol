import "./SecurityCrowdsaleToken.sol";
import "./WhiteListContract.sol";
import "../../node_modules/zeppelin-solidity/contracts/ownership/Ownable.sol";


pragma solidity ^0.4.21;


contract EIP20Factory is Ownable {

    mapping(address => address[]) public created;
    mapping(address => bool) public isEIP20; //verify without having to do a bytecode check.
    bytes public EIP20ByteCode; // solhint-disable-line var-name-mixedcase
    WhiteListContract public whiteList;
    address public verifiedToken;

    function EIP20Factory() public {
        //upon creation of the factory, deploy a EIP20 (parameters are meaningless) and store the bytecode provably.

        whiteList = (new WhiteListContract());
        verifiedToken = createEIP20(10000, "Verify Token", 3, "VTX", 0x3C9DA12EdA40d69713ef7c6129E5ebd75983ac3D);
        return;
    }

    function createEIP20(uint256 _initialAmount, string _name, uint8 _decimals, string _symbol, address _token_owner)
    public
    onlyOwner
    returns (address) {

        addAddressToWhitelist(_token_owner);
        SecurityCrowdsaleToken newToken = (new SecurityCrowdsaleToken(_initialAmount, _name, _decimals, _symbol, _token_owner, whiteList));
        created[msg.sender].push(address(newToken));
        isEIP20[address(newToken)] = true;
        //the factory will own the created tokens. You must transfer them.
        //newToken.transfer(msg.sender, _initialAmount);
        return address(newToken);
    }

    function addAddressToWhitelist(address _operator)
    public
    onlyOwner
    {
        whiteList.addAddressToWhitelist(_operator);
    }

    function whitelist(address _operator)
    public
    view
    returns (bool)
    {
        return whiteList.whitelist(_operator);
    }

    function addAddressesToWhitelist(address[] _operators)
    public
    onlyOwner
    {
        whiteList.addAddressesToWhitelist(_operators);
    }

    function removeAddressFromWhitelist(address _operator)
    public
    onlyOwner
    {
        whiteList.removeAddressFromWhitelist(_operator);
    }

    function removeAddressesFromWhitelist(address[] _operators)
    public
    onlyOwner
    {
        whiteList.removeAddressesFromWhitelist(_operators);
    }

}
