//SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.7;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

import "./libraries/stringsutils.sol";
import "./libraries/Base64.sol";

contract SigilsOfTheEther is ERC721Enumerable {
    using stringsutils for string;

    uint256 public nonce = 0;
    mapping(uint256 => string) public imgSVG;
    mapping(bytes1 => string[2]) internal coordinates;

    constructor() ERC721("SigilsOfTheEther", "SIGIL") {
        coordinates[bytes1("A")][0] = "392";
        coordinates[bytes1("A")][1] = "107.7";
        coordinates[bytes1("B")][0] = "335.03";
        coordinates[bytes1("B")][1] = "392";
        coordinates[bytes1("C")][0] = "221.37";
        coordinates[bytes1("C")][1] = "107.7";
        coordinates[bytes1("D")][0] = "278.34";
        coordinates[bytes1("D")][1] = "392";
        coordinates[bytes1("E")][0] = "164.68";
        coordinates[bytes1("E")][1] = "392";
        coordinates[bytes1("F")][0] = "107.7";
        coordinates[bytes1("F")][1] = "107.7";
        coordinates[bytes1("G")][0] = "107.7";
        coordinates[bytes1("G")][1] = "164.68";
        coordinates[bytes1("H")][0] = "335.03";
        coordinates[bytes1("H")][1] = "164.68";
        coordinates[bytes1("I")][0] = "278.34";
        coordinates[bytes1("I")][1] = "335.03";
        coordinates[bytes1("J")][0] = "221.37";
        coordinates[bytes1("J")][1] = "335.03";
        coordinates[bytes1("K")][0] = "164.68";
        coordinates[bytes1("K")][1] = "164.68";
        coordinates[bytes1("L")][0] = "392";
        coordinates[bytes1("L")][1] = "335.03";
        coordinates[bytes1("M")][0] = "392";
        coordinates[bytes1("M")][1] = "278.06";
        coordinates[bytes1("N")][0] = "164.68";
        coordinates[bytes1("N")][1] = "221.37";
        coordinates[bytes1("O")][0] = "278.34";
        coordinates[bytes1("O")][1] = "221.37";
        coordinates[bytes1("P")][0] = "221.37";
        coordinates[bytes1("P")][1] = "221.37";
        coordinates[bytes1("Q")][0] = "335.03";
        coordinates[bytes1("Q")][1] = "278.06";
        coordinates[bytes1("R")][0] = "107.7";
        coordinates[bytes1("R")][1] = "278.06";
        coordinates[bytes1("S")][0] = "107.7";
        coordinates[bytes1("S")][1] = "221.37";
        coordinates[bytes1("T")][0] = "164.68";
        coordinates[bytes1("T")][1] = "278.06";
        coordinates[bytes1("U")][0] = "278.34";
        coordinates[bytes1("U")][1] = "278.06";
        coordinates[bytes1("V")][0] = "221.37";
        coordinates[bytes1("V")][1] = "278.06";
        coordinates[bytes1("W")][0] = "335.03";
        coordinates[bytes1("W")][1] = "221.37";
        coordinates[bytes1("X")][0] = "392";
        coordinates[bytes1("X")][1] = "221.37";
        coordinates[bytes1("Y")][0] = "107.7";
        coordinates[bytes1("Y")][1] = "335.03";
        coordinates[bytes1("Z")][0] = "335.03";
        coordinates[bytes1("Z")][1] = "335.03";
        coordinates[bytes1("0")][0] = "221.37";
        coordinates[bytes1("0")][1] = "164.68";
        coordinates[bytes1("1")][0] = "164.68";
        coordinates[bytes1("1")][1] = "164.68";
        coordinates[bytes1("2")][0] = "164.68";
        coordinates[bytes1("2")][1] = "335.03";
        coordinates[bytes1("3")][0] = "392";
        coordinates[bytes1("3")][1] = "164.68";
        coordinates[bytes1("4")][0] = "392";
        coordinates[bytes1("4")][1] = "392";
        coordinates[bytes1("5")][0] = "164.68";
        coordinates[bytes1("5")][1] = "107.7";
        coordinates[bytes1("6")][0] = "221.37";
        coordinates[bytes1("6")][1] = "392";
        coordinates[bytes1("7")][0] = "278.34";
        coordinates[bytes1("7")][1] = "107.7";
        coordinates[bytes1("8")][0] = "335.03";
        coordinates[bytes1("8")][1] = "107.7";
        coordinates[bytes1("9")][0] = "107.7";
        coordinates[bytes1("9")][1] = "392";
    }

    function cast(
        string memory input,
        string memory color,
        uint8 mode
    ) external {
        require(
            mode <= 2,
            "mode needs to be: 0 = execute, 1 = store, 2 = mint"
        );

        string memory svg = generateSVG(input, color);

        if (mode == 0) {
            return;
        }
        if (mode > 0) {
            imgSVG[nonce] = svg;
        }
        if (mode > 1) {
            _safeMint(msg.sender, nonce);
        }
        ++nonce;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(
                        bytes(
                            string(
                                abi.encodePacked(
                                    '{"name": "Talisman #',
                                    toString(tokenId),
                                    '", "description": "This intention has been Cast into the Ether", "attributes": [], "image": "',
                                    imgSVG[tokenId],
                                    '"}'
                                )
                            )
                        )
                    )
                )
            );
    }

    function generateSVG(string memory input, string memory color)
        public
        view
        returns (string memory)
    {
        require(bytes(input).length > 0, "input can not be empty");
        require(bytes(color).length > 0, "color can not be empty");
        string memory combined;
        for (uint256 i = 0; i < bytes(input).length; i++) {
            combined = string(
                abi.encodePacked(
                    combined,
                    getCoordinatesString(bytes(input)[i])
                )
            );
        }

        bytes1 first = bytes(input)[0];
        bytes1 last = bytes(input)[bytes(input).length - 1];

        string memory output = string(
            abi.encodePacked(
                '<svg  xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 500 500"><style>.base{fill:',
                color,
                ";font-size:60px;} .shape{fill:none;stroke:",
                color,
                ';stroke-width:4}</style><rect width="100%" height="100%" fill="black" /><circle style="stroke-width:9" cx="250" cy="250" r="230" class="shape"/><polyline class="shape" points="',
                combined,
                '"/><circle cx="',
                coordinates[first][0],
                '" cy="',
                coordinates[first][1],
                '" r="15" class="shape"/><text x="',
                coordinates[last][0],
                '" y="',
                coordinates[last][1],
                '" class="base" dx="-16.95" dy="15.2">+</text></svg>'
            )
        );

        return
            string(
                abi.encodePacked(
                    "data:image/svg+xml;base64,",
                    Base64.encode(bytes(output))
                )
            );
    }

    function getCoordinatesString(bytes1 input)
        internal
        view
        returns (string memory)
    {
        if (bytes(coordinates[input][0]).length == 0) {
            return "";
        }
        return
            string(
                abi.encodePacked(
                    coordinates[input][0],
                    ",",
                    coordinates[input][1],
                    " "
                )
            );
    }

    function toString(uint256 value) internal pure returns (string memory) {
        // Inspired by OraclizeAPI's implementation - MIT license
        // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

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
}
