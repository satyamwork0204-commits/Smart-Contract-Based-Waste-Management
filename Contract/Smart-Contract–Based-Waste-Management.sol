// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title Smart Contract–Based Waste Management
 * @dev A simple contract to register waste, mark it collected, and reward collectors.
 */
contract Project {
    
    struct Waste {
        uint256 id;
        string wasteType;
        address owner;
        bool collected;
    }

    uint256 public wasteCount = 0;
    mapping(uint256 => Waste) public wastes;

    event WasteRegistered(uint256 id, string wasteType, address owner);
    event WasteCollected(uint256 id, address collector);

    /**
     * @dev Register a new type of waste.
     * @param _wasteType Name/type of waste.
     */
    function registerWaste(string memory _wasteType) external {
        wasteCount++;

        wastes[wasteCount] = Waste({
            id: wasteCount,
            wasteType: _wasteType,
            owner: msg.sender,
            collected: false
        });

        emit WasteRegistered(wasteCount, _wasteType, msg.sender);
    }

    /**
     * @dev Mark waste as collected (only if not already collected).
     * @param _id Waste ID to mark as collected.
     */
    function markCollected(uint256 _id) external {
        Waste storage w = wastes[_id];
        require(!w.collected, "Already collected");

        w.collected = true;

        emit WasteCollected(_id, msg.sender);
    }

    /**
     * @dev Retrieve waste details.
     */
    function getWaste(uint256 _id) external view returns (Waste memory) {
        return wastes[_id];
    }
}

