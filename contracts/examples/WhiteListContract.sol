pragma solidity ^0.4.24;

import "../../node_modules/zeppelin-solidity/contracts/access/Whitelist.sol";
/**
 * @title SimpleToken
 * @dev Very simple ERC20 Token example, where all tokens are pre-assigned to the creator.
 * Note they can later distribute these tokens as they wish using `transfer` and other
 * `ERC20` functions.
 */
contract WhiteListContract is Whitelist {

    constructor() public {
        return;
    }

}
