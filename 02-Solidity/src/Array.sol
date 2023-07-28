// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.4;

contract ArrayContract {

  uint[] public lastResult;

  function remove(uint[] memory arr, uint[] memory indexes) public returns(uint[] memory) {
    require(arr.length > 0, "Array 'arr' must not be empty");
    require(indexes.length > 0, "Array 'indexes' must not be empty");

    // Validate that 'indexes' elements are within bounds of 'arr'
    for (uint i = 0; i < indexes.length; i++) {
      require(indexes[i] < arr.length, "Index out of bounds");
    }

    // sort indexes array
    sortArray(indexes);

    // variable to store counter
    uint counter = 0;

    // loop to asign to arr new values 
    for (uint i = 0; i < arr.length - indexes.length; i++) {  
      if (i == indexes[counter] && indexes.length > counter) {
        counter++;
      }
      if (counter < 2) {
        arr[i] = arr[i + counter];
      } else {
        arr[i] = arr[i + counter -1];
      }
    }

    // pop arr to remove unused items
    if(indexes.length > 1) {
      for (uint i = 0; i <= counter; i++) { 
        assembly { mstore(arr, sub(mload(arr), 1)) }
      }
    } else {
      assembly { mstore(arr, sub(mload(arr), 1)) }
    }

    // save in a state variable for tests propuses
    lastResult = arr;

    return arr;
  }

  function sortArray(uint[] memory arr) private pure {
    uint n = arr.length;
    for (uint i = 0; i < n - 1; i++) {
      for (uint j = 0; j < n - i - 1; j++) {
        if (arr[j] > arr[j + 1]) {
          // Swap elements to sort in ascending order
          uint temp = arr[j];
          arr[j] = arr[j + 1];
          arr[j + 1] = temp;
        }
      }
    }
  }
}