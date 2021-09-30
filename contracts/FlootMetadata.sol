// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { BlindDrop } from "./BlindDrop.sol";
import { Base64 } from "./Base64.sol";
import { ERC721EnumerableOptimized } from "./ERC721EnumerableOptimized.sol";
import { FlootConstants } from "./FlootConstants.sol";

/**
 * @title FlootMetadata
 * @author the-torn
 *
 * @notice Logic for generating metadata, including the SVG graphic with text.
 *
 *  Based closely on the original Loot implementation (MIT License).
 *  https://etherscan.io/address/0xff9c1b15b16263c61d017ee9f65c50e4ae0113d7#code#L1
 */
abstract contract FlootMetadata is
  BlindDrop,
  ERC721EnumerableOptimized
{
  function random(
    string memory input
  )
    internal
    pure
    returns (uint256)
  {
    return uint256(keccak256(abi.encodePacked(input)));
  }

  function getMove(
    uint256 tokenId,
    uint256 moveId
  )
    public
    view
    returns (string memory, string memory)
  {
    return pluckMove(tokenId, moveId);
  }

  function getType(
    uint256 tokenId,
    string memory typeId
  )
    public
    view
    returns (string memory)
  {
    return pluck(tokenId, typeId, FlootConstants.ListName.TYPE);
  }

  function pluckMove(
    uint256 tokenId,
    uint256 moveId
  )
    internal
    view
    returns (string memory, string memory)
  {
    // Get the blind drop seed. Will revert if the distribution is not complete or if the seed
    // has not yet been finalized.
    bytes32 seed = getFinalSeed();

    // On-chain randomness.
    string memory inputForRandomness = string(abi.encodePacked(
      FlootConstants.ListName.MOVE_NAME,
      tokenId, // Note: No need to use toString() here.
      seed,
      moveId
    ));
    uint256 rand = random(inputForRandomness);

    // Determine the item name based on the randomly generated number.
    string memory output = FlootConstants.getItem(rand, FlootConstants.ListName.MOVE_NAME);
    string memory moveType = FlootConstants.getItem(rand, FlootConstants.ListName.TYPE_OF_MOVE);
    return (output, moveType);
  }

  function pluck(
    uint256 tokenId,
    string memory typeId,
    FlootConstants.ListName keyPrefix
  )
    internal
    view
    returns (string memory)
  {
    // Get the blind drop seed. Will revert if the distribution is not complete or if the seed
    // has not yet been finalized.
    bytes32 seed = getFinalSeed();

    // On-chain randomness.
    string memory inputForRandomness = string(abi.encodePacked(
      keyPrefix,
      tokenId, // Note: No need to use toString() here.
      seed,
      typeId
    ));
    uint256 rand = random(inputForRandomness);
    uint256 greatness = rand % 21;
    if(greatness < 18) {
      return typeId;
    } else {
      // Determine the item name based on the randomly generated number.
      string memory output = FlootConstants.getItem(rand, keyPrefix);
      return output;
    }
  }

  function rdm(uint number) private view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, number))) % 4 + 5;
  } 

  function tokenURI(
    uint256 tokenId
  )
    override
    public
    view
    returns (string memory)
  {
    (string memory move, string memory moveType) = getMove(tokenId, 1);
    (string memory secondMove, string memory secondMoveType) = getMove(tokenId, 2);
    (string memory thirdMove, string memory thirdMoveType) = getMove(tokenId, 3);
    (string memory fourthMove, string memory fourthMoveType) = getMove(tokenId, 4);

    string[33] memory parts;
    parts[0] = '<svg width="400" height="250" xmlns="http://www.w3.org/2000/svg"><style>rect.move {stroke:white; stroke-width:1px;} rect.square {stroke:white; stroke-width:1px;}</style><rect x="0" y="0" width="150" height="50" rx="10" ry="10" fill="#000000" class="square"/><text x="25" y="25" dominant-baseline="middle" text-anchor="middle" fill="white">';
    parts[1] = FlootConstants.toString(rdm(1));
    parts[2] = '</text><rect x="50" y="0" width="50" height="50" rx="10" ry="10" fill="#0" class="square"/><text x="75" y="25" dominant-baseline="middle" text-anchor="middle" fill="white">';
    parts[3] = FlootConstants.toString(rdm(2));
    parts[4] = '</text><rect x="100" y="0" width="50" height="50" rx="10" ry="10" fill="#0" class="square"/><text x="125" y="25" dominant-baseline="middle" text-anchor="middle" fill="white">';
    parts[5] = FlootConstants.toString(rdm(3));
    parts[6] = '</text><rect x="150" y="0" width="50" height="50" rx="10" ry="10" fill="';
    parts[7] = getType(tokenId, thirdMoveType);
    parts[8] = '" class="square"/><rect x="200" y="0" width="50" height="50" rx="10" ry="10" fill="';
    parts[9] = getType(tokenId, moveType);
    parts[10] = '" class="square"/><text x="225" y="25" dominant-baseline="middle" text-anchor="middle" fill="white"></text><rect x="250" y="0" width="150" height="50" rx="10" ry="10" fill="#0" class="square"/><rect x="250" y="0" width="50" height="50" rx="10" ry="10" fill="0" class="square"/><text x="275" y="25" dominant-baseline="middle" text-anchor="middle" fill="white">';
    parts[11] = FlootConstants.toString(rdm(4));
    parts[12] = '</text><rect x="300" y="0" width="50" height="50" rx="10" ry="10" fill="#0" class="square"/><text x="325" y="25" dominant-baseline="middle" text-anchor="middle" fill="white">';
    parts[13] = FlootConstants.toString(rdm(5));
    parts[14] = '</text><text x="375" y="25" dominant-baseline="middle" text-anchor="middle" fill="white">';
    parts[15] = FlootConstants.toString(rdm(6));
    parts[16] = '</text><rect x="0" y="50" width="200" height="100" rx="10" ry="10" fill="';
    parts[17] = moveType;
    parts[18] = '" class="move"/><text x="100" y="100" dominant-baseline="middle" text-anchor="middle" fill="white">';
    parts[19] = move;
    parts[20] = '</text><rect x="200" y="50" width="200" height="100" rx="10" ry="10" fill="';
    parts[21] = secondMoveType;
    parts[22] = '" class="move"/><text x="300" y="100" dominant-baseline="middle" text-anchor="middle" fill="white">';
    parts[23] = secondMove;
    parts[24] = '</text><rect x="0" y="150" width="200" height="100" rx="10" ry="10" fill="';
    parts[25] = thirdMoveType;
    parts[26] = '" class="move"/><text x="100" y="200" dominant-baseline="middle" text-anchor="middle" fill="white">';
    parts[27] = thirdMove;
    parts[28] = '</text><rect x="200" y="150" width="200" height="100" rx="10" ry="10" fill="';
    parts[29] = fourthMoveType;
    parts[30] = '" class="move"/><text x="300" y="200" dominant-baseline="middle" text-anchor="middle" fill="white">';
    parts[31] = fourthMove;
    parts[32] = '</text></svg>';

    string memory output = string(abi.encodePacked(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5], parts[6], parts[7], parts[8]));
    output = string(abi.encodePacked(output, parts[9], parts[10], parts[11], parts[12], parts[13], parts[14], parts[15], parts[16]));
    output = string(abi.encodePacked(output, parts[17], parts[18], parts[19], parts[20], parts[21], parts[22], parts[23], parts[24]));
    output = string(abi.encodePacked(output, parts[25], parts[26], parts[27], parts[28], parts[29], parts[30], parts[31], parts[32]));

    string memory json = Base64.encode(bytes(string(abi.encodePacked(
      '{"name": "Ethereal #',
      FlootConstants.toString(tokenId),
      '", "description": "Ethereals are blueprints for digital turn based battlers. Each includes a 4-move set, 6 base stats and 1 or 2 types. Feel free to use Ethereals in any way you want.", "image": "data:image/svg+xml;base64,',
      Base64.encode(bytes(output)),
      '"}'
    ))));
    output = string(abi.encodePacked('data:application/json;base64,', json));

    return output;
  }
}
