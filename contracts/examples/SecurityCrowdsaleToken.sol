pragma solidity ^0.4.24;

import "../token/ERC20/ERC20.sol";
import "./WhiteListContract.sol";

/**
 * @title SimpleToken
 * @dev Very simple ERC20 Token example, where all tokens are pre-assigned to the creator.
 * Note they can later distribute these tokens as they wish using `transfer` and other
 * `ERC20` functions.
 */
contract SecurityCrowdsaleToken is ERC20 {

    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    WhiteListContract public white_list_address;

    mapping (address => uint256) public balances;


    /**
     * @dev Constructor that gives msg.sender all of existing tokens.
     */
    constructor(uint256 _initialAmount, string _name, uint8 _decimals, string _symbol, address _token_owner, WhiteListContract _white_list_address) public {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = 10000 * (10 ** uint256(decimals));
        balances[_token_owner] = _initialAmount;
        white_list_address = _white_list_address;

        _mint(_token_owner, totalSupply);
    }


    function _mint(address account, uint256 value) internal {
        require(account != 0);
        require(white_list_address.whitelist(account));
        totalSupply = totalSupply.add(value);
        balances[account] = balances[account].add(value);
        emit Transfer(address(0), account, value);
    }

    function transfer(address to, uint256 value) public returns (bool) {
        require(white_list_address.whitelist(msg.sender));
        require(white_list_address.whitelist(to));
        _transfer(msg.sender, to, value);
        return true;
    }

}
