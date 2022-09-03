// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract SimpleStorage {
    // This gets initialzed to zero
    uint256 public favoriteNumber;

    mapping(string => uint256) public nameToFavoriteNumber;

    function store(uint256 _favoriteNumber) public virtual {
        favoriteNumber = _favoriteNumber;
        retrieve();
    }

    function retrieve() public view returns (uint256) {
        return favoriteNumber;
    }

    struct People {
        uint256 favoriteNumber;
        string name;
    }

    People[] public people;

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        // People memory newPerson = People({favoriteNumber: _favoriteNumber, name: _name});
        People memory newPerson = People(_favoriteNumber, _name);
        people.push(newPerson);

        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}

// 0x7EF2e0048f5bAeDe046f6BF797943daF4ED8CB47
