pragma solidity ^0.5.0;

import "./NearProver.sol";
import "../nearbridge/Borsh.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Mintable.sol";

contract BridgedToken is ERC20Burnable,ERC20Detailed,ERC20Mintable {
    constructor(string memory name, string memory symbol, uint8 decimals) ERC20Detailed(name,symbol,decimals) public{}
}
/**
 * @title Owner
 * @dev Set & change owner
 */
contract RainbowWars is NearProver {
    using Borsh for Borsh.Data;

    struct attackInfo {
        address beneficiary;
        uint256 seed;
    }
    
    uint256 public difficult = 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;
    uint256 public bulletPrice = 1 ;
    uint256 public attackIndex;
    attackInfo[] public attackHistory;
    
    uint256 public otherDifficult = 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;
    //uint256 
    
    event etherAttack(address indexed attacker, uint256 indexed bullet, uint256 difficult, uint256 timestamp, bytes32 beneficiary);
    bytes32 constant attackSig = keccak256("etherAttack(address,uint256,uint256,uint256,bytes32)");
    bytes32 constant bridgeHash = keccak256("lee.testnet");
    mapping (bytes32 => bool) public spending;
    BridgedToken public rewardsToken;

    modifier step(){
        deal();
        _;
    }
    /**
     * @dev Set contract deployer as owner
     */
    constructor() public {
        rewardsToken = new BridgedToken("eBridge", "eBridge", 6);
    }
    
    function getBlockHash(uint256 blockNo) private returns(bytes32){
        //return keccak256(abi.encodePacked(difficult, otherDifficult, msg.sender, address(this), blockNo, attackIndex, attackHistory.length, bulletPrice));
        return blockhash(blockNo);
    }
    
    function thisSideEvent() private {
        difficult--;
    }
    
    function otherSideEvent() private {
        difficult-=10;
    }

    function attack(bytes32 beneficiary) public payable step {
        thisSideEvent();
        uint256 bullet = msg.value/bulletPrice;
        require(bullet > 0 && bullet < 10, "bullet need between (0,10)");
        uint256 totalSpend = bullet*bulletPrice;
        if(totalSpend < msg.value) msg.sender.transfer(msg.value - totalSpend);
        emit etherAttack(msg.sender, bullet, difficult, block.timestamp, beneficiary);
    }
    
    function onAttackEvent(bytes32 attacker, uint256 bullet, uint256 _difficult, uint256 timestamp, address beneficiary) private {
        otherSideEvent();
        require(otherDifficult != _difficult, "difficult can't equeal");
        if(otherDifficult > _difficult) otherDifficult = _difficult;
        //require(timestamp < block.timestamp && block.timestamp < timestamp + 1 days, "attack must be within a day");
        uint256 attackSeed = uint256(keccak256(abi.encodePacked(attacker, bullet, otherDifficult, timestamp)));
        attackHistory.push(attackInfo(beneficiary, attackSeed&(~uint256(0xffffffff))|block.number));
    }
    
    function deal() public {
        if(attackIndex >= attackHistory.length) return;
        attackInfo storage attackSeed = attackHistory[attackIndex];
        uint256 attackBlockNo = attackSeed.seed&0xffffffff;
        if(attackBlockNo == block.number) return;
        attackIndex++;
        bytes32 attackBlockHash = getBlockHash(attackBlockNo);
        bytes32 dealParentHash = getBlockHash(block.number - 1);
        uint256 defenSeed = uint256(keccak256(abi.encodePacked(difficult, block.number, dealParentHash)));
        uint256 finalAttackSeed = uint256(keccak256(abi.encodePacked(attackSeed.seed, attackBlockNo, attackBlockHash, defenSeed)));
        uint256 attackValue = otherDifficult + finalAttackSeed;
        uint256 defenValue = difficult + defenSeed;
        if(attackValue < defenValue){
            rewardsToken.mint(attackSeed.beneficiary, 1e7);
        }else{
            rewardsToken.mint(attackSeed.beneficiary, 1e6);
        }
        if(difficult > finalAttackSeed) difficult = finalAttackSeed;
    }
    
    function BurnReward(uint256 amount) public step {
        uint256 totalSupply = rewardsToken.totalSupply();
        rewardsToken.burnFrom(msg.sender, amount);
        msg.sender.transfer(address(this).balance * amount/totalSupply);
    }

    function ExecProof(bytes memory proofData, uint64 blockHeight) public step {
        (bytes32 bridge, bytes32 receipt, bytes memory successValue) =  proveOutcome(proofData, blockHeight);
        require(spending[receipt] == false, "double spending!");
        spending[receipt] = true;
        require(bridge == bridgeHash, "from anthor birdge!");
        
        Borsh.Data memory borshData = Borsh.from(successValue);
        bytes32 eventSig = borshData.decodeBytes32();
        if(eventSig == attackSig) {
            bytes32 attacker = borshData.decodeBytes32();
            uint256 bullet = uint256(borshData.decodeBytes32());
            uint256 _difficult = uint256(borshData.decodeBytes32());
            uint256 timestamp = uint256(borshData.decodeBytes32());
            address beneficiary = address(uint160(uint256(borshData.decodeBytes32())));
            onAttackEvent(attacker, bullet, _difficult, timestamp, beneficiary);
            return;
        }
        revert("none valid event!");
    }
}