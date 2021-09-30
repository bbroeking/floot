// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { strings } from "./strings.sol";

/**
 * @title FlootConstants
 * @author the-torn
 *
 * @notice External library for constants used by Floot.
 *
 *  Adapted directly from the original Loot. The CSV optimization is owed to zefram.eth.
 *  This is an external library in order to keep the main contract within the bytecode limit.
 */
library FlootConstants {
  using strings for string;
  using strings for strings.slice;

  enum ListName {
    MOVE_NAME,
    TYPE_OF_MOVE,
    TYPE
  }

  string internal constant MOVES = "Absorb,Acid,Acid Armor,Agility,Amnesia,Aurora Beam,Barrage,Barrier,Bide,Bind,Bite,Blizzard,Body Slam,Bone Club,Bonemerang,Bubble,Bubble Beam,Clamp,Comet Punch,Confuse Ray,Confusion,Constrict,Conversion,Counter,Crabhammer,Cut,Defense Curl,Dig,Disable,Dizzy Punch,Double Kick,Double Slap,Double Team,Double-Edge,Dragon Rage,Dream Eater,Drill Peck,Earthquake,Egg Bomb,Ember,Explosion,Fire Blast,Fire Punch,Fire Spin,Fissure,Flamethrower,Flash,Fly,Focus Energy,Fury Attack,Fury Swipes,Glare,Growl,Growth,Guillotine,Gust,Harden,Haze,Headbutt,High Jump Kick,Horn Attack,Horn Drill,Hydro Pump,Hyper Beam,Hyper Fang,Hypnosis,Ice Beam,Ice Punch,Jump Kick,Karate Chop,Kinesis,Leech Life,Leech Seed,Leer,Lick,Light Screen,Lovely Kiss,Low Kick,Meditate,Mega Drain,Mega Kick,Mega Punch,Metronome,Mimic,Minimize,Mirror Move,Mist,Night Shade,Pay Day,Peck,Petal Dance,Pin Missile,Poison Gas,Poison Powder,Poison Sting,Pound,Psybeam,Psychic,Psywave,Quick Attack,Rage,Razor Leaf,Razor Wind,Recover,Reflect,Rest,Roar,Rock Slide,Rock Throw,Rolling Kick,Sand Attack,Scratch,Screech,Seismic Toss,Self-Destruct,Sharpen,Sing,Skull Bash,Sky Attack,Slam,Slash,Sleep Powder,Sludge,Smog,Smokescreen,Soft-Boiled,Solar Beam,Sonic Boom,Spike Cannon,Splash,Spore,Stomp,Strength,String Shot,Struggle,Stun Spore,Submission,Substitute,Super Fang,Supersonic,Surf,Swift,Swords Dance,Tackle,Tail Whip,Take Down,Teleport,Thrash,Thunder,Thunder Punch,Thunder Shock,Thunder Wave,Thunderbolt,Toxic,Transform,Tri Attack,Twineedle,Vice Grip,Vine Whip,Water Gun,Waterfall,Whirlwind,Wing Attack,Withdraw,Wrap";
  uint256 internal constant MOVES_LENGTH = 165;

  string internal constant TYPE_OF_MOVE = "#78c84f,#9f409f,#9f409f,#f85787,#f85787,#98d8d8,#a8a877,#f85787,#a8a877,#a8a877,#705848,#98d8d8,#a8a877,#e0c068,#e0c068,#6790f0,#6790f0,#6790f0,#a8a877,#705898,#f85787,#a8a877,#a8a877,#c03028,#6790f0,#a8a877,#a8a877,#e0c068,#a8a877,#a8a877,#c03028,#a8a877,#a8a877,#a8a877,#7038f8,#f85787,#a890f0,#e0c068,#a8a877,#ef8030,#a8a877,#ef8030,#ef8030,#ef8030,#e0c068,#ef8030,#a8a877,#a890f0,#a8a877,#a8a877,#a8a877,#a8a877,#a8a877,#a8a877,#a8a877,#a890f0,#a8a877,#98d8d8,#a8a877,#c03028,#a8a877,#a8a877,#6790f0,#a8a877,#a8a877,#f85787,#98d8d8,#98d8d8,#c03028,#c03028,#f85787,#a8b720,#78c84f,#a8a877,#705898,#f85787,#a8a877,#c03028,#f85787,#78c84f,#a8a877,#a8a877,#a8a877,#a8a877,#a8a877,#a890f0,#98d8d8,#705898,#a8a877,#a890f0,#78c84f,#a8b720,#9f409f,#9f409f,#9f409f,#a8a877,#f85787,#f85787,#f85787,#a8a877,#a8a877,#78c84f,#a8a877,#a8a877,#f85787,#f85787,#a8a877,#b8a038,#b8a038,#c03028,#e0c068,#a8a877,#a8a877,#c03028,#a8a877,#a8a877,#a8a877,#a8a877,#a890f0,#a8a877,#a8a877,#78c84f,#9f409f,#9f409f,#a8a877,#a8a877,#78c84f,#a8a877,#a8a877,#a8a877,#78c84f,#a8a877,#a8a877,#a8b720,#a8a877,#78c84f,#c03028,#a8a877,#a8a877,#a8a877,#6790f0,#a8a877,#a8a877,#a8a877,#a8a877,#a8a877,#f85787,#a8a877,#f8cf30,#f8cf30,#f8cf30,#f8cf30,#f8cf30,#9f409f,#a8a877,#a8a877,#a8b720,#a8a877,#78c84f,#6790f0,#6790f0,#a8a877,#a890f0,#6790f0,#a8a877";
  uint256 internal constant TYPE_OF_MOVE_LENGTH = 165;

  string internal constant TYPES = "#a8a877,#ef8030,#6790f0,#78c84f,#f8cf30,#98d8d8,#c03028,#9f409f,#e0c068,#a890f0,#f85787,#a8b720,#b8a038,#705898,#705848,#7038f8,#b8b8d0,#f0b6bc";
  uint256 internal constant TYPES_LENGTH = 18;

  function getItem(
    uint256 rand,
    ListName listName
  )
    external
    pure
    returns (string memory)
  {
    if (listName == ListName.MOVE_NAME) {
      return getItemFromCsv(MOVES, rand % MOVES_LENGTH);
    }
    if (listName == ListName.TYPE_OF_MOVE) {
      return getItemFromCsv(TYPE_OF_MOVE, rand % TYPE_OF_MOVE_LENGTH);
    }
    if (listName == ListName.TYPE) {
      return getItemFromCsv(TYPES, rand % TYPES_LENGTH);
    }
    revert("Invalid list name");
  }

  /**
   * @notice Convert an integer to a string.
   *
   * Inspired by OraclizeAPI's implementation (MIT license).
   * https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol
   */
  function toString(
    uint256 value
  )
    internal
    pure
    returns (string memory)
  {
    if (value == 0) {
      return "0";
    }
    uint256 temp = value;
    uint256 digits;
    while (temp != 0) {
      digits++;
      temp /= 10;
    }
    bytes memory buffer = new bytes(digits);
    while (value != 0) {
      digits -= 1;
      buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
      value /= 10;
    }
    return string(buffer);
  }

  /**
   * @notice Read an item from a string of comma-separated values.
   *
   * Based on zefram.eth's implementation (MIT license).
   * https://etherscan.io/address/0xb9310af43f4763003f42661f6fc098428469adab#code
   */
  function getItemFromCsv(
    string memory str,
    uint256 index
  )
    internal
    pure
    returns (string memory)
  {
    strings.slice memory strSlice = str.toSlice();
    string memory separatorStr = ",";
    strings.slice memory separator = separatorStr.toSlice();
    strings.slice memory item;
    for (uint256 i = 0; i <= index; i++) {
      item = strSlice.split(separator);
    }
    return item.toString();
  }
}
