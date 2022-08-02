// SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

// 对address数组进行操作
library ArrayLibAddress {
    // 在给定数组中找到对应元素的索引
    function find(address[] storage arr, address v)
        internal
        view
        returns (uint256)
    {
        for (uint256 i = 0; i < arr.length; i++) {
            if (arr[i] == v) {
                return i;
            }
        }
        revert("not found");
    }

    // 根据索引删除元素（不保证顺序）
    function removeByIndex(address[] storage arr, uint256 _index) internal {
        require(_index < arr.length, "index out of bound");
        arr[_index] = arr[arr.length - 1];
        arr.pop();
    }

    // 根据值是否相等删除第一个相等的元素（不保证顺序）
    function removeByVal(address[] storage arr, address val) internal {
        uint256 _index = find(arr, val);
        removeByIndex(arr, _index);
    }

    // 固定切24个，第一位返回数组长度
    function slice24(address[] memory arr, uint256 page)
        internal
        pure
        returns (address[24] memory)
    {
        uint start = page*24;
        uint256 end = start + 24;
        if (end >= arr.length) {
            end = arr.length;
        }
        address[24] memory res;
        if (page == 0) {
            // 就把第一位赋值为数组长度
            res[0] = address(uint160(arr.length));
            for (uint256 i = 1; i < end; i++) {
                res[i] = arr[i - 1];
            }
        } else {
            for (uint256 i = start; i < end; i++) {
                res[i] = arr[i - 1];
            }
        }
        return res;
    }
}
