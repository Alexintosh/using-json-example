// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@forge-std/Test.sol";
import "@forge-std/StdJson.sol";
import "@forge-std/console.sol";
import "../src/Counter.sol";

struct Children {
    uint256 age;
    string name;
    
}

struct CurrentJob {
    string title;
    string salary;
}

contract CounterTest is Test {
    Counter public counter;
    using stdJson for string;

    function setUp() public {
        counter = new Counter(address(0));
        counter.setNumber(0);
    }

    function testJson() public {
        string memory root = vm.projectRoot();
        string memory path = string.concat(root, "/test/ameen.json");
        string memory json = vm.readFile(path);

        // Single value
        bytes memory x = json.parseRaw(".currentJob");
        CurrentJob memory child = abi.decode(x, (CurrentJob));
        console.log(child.salary);

        // Array
        bytes memory foo = json.parseRaw(".children");        
        Children[] memory arrChild = abi.decode(foo, (Children[]));

        for (uint i = 0; i < arrChild.length; i++) {
            console.log(arrChild[i].name);
        }
        
    }

    
}
