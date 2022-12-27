pragma solidity ^0.8.0;

import "https://github.com/bokkypoobah/BokkyPooBahsDateTimeLibrary/blob/master/contracts/BokkyPooBahsDateTimeLibrary.sol";

contract Teammates7 {
    string _ownerName;
    address _ownerAddress;
    Teammate[] _teammates;
    // address[] _presentReceived;
    uint256 constant PRESENT = 100000000000000000;
    constructor() {
        _ownerName = "Roman";
        _ownerAddress = msg.sender;
        
    }
    // Новий функціонал - struct. Це по суті структура данних
    struct Teammate {
        address account;
        string name;
        uint256 birthday;
        bool presentReceived;
    }

    function addTeammate (string memory name, address account, uint256 birthday) public ownerOnly {
        Teammate memory NewTeammate = Teammate(account, name, birthday, false);
        _teammates.push(NewTeammate);
    }
    function getTeammate (uint256 index) view public returns(Teammate memory) {
        return _teammates[index];
    }
    // Пошук іменинників та посилка їм подарунків
    function findBirthdayAndSend () public ownerOnly {
        for (uint256 i = 0; i < _teammates.length; i++) {
            if (checkBirthday(i) && !_teammates[i].presentReceived) {
                // вшив код birthdayPayout відразу сюди, думав можливо рідше Ремікс крашитись буде
                payable (_teammates[i].account).transfer(PRESENT);
                _teammates[i].presentReceived = true;
            } else if (!checkBirthday(i)) _teammates[i].presentReceived = false; 
        }
    }
    // // Відсилання подарунку
    //  function birthdayPayout(uint256 index) private {
    //     if (!_teammates[index].presentReceived) {
    //     payable (_teammates[index].account).transfer(PRESENT);
    //     _teammates[index].presentReceived = true;
    //      }

        /* Довелось прибрати, так як якщо додати ще одного іменинника після того як уже зробив
        розсилку подарунків, ітератор в findBirthday не доходив до цього іменинника
        else revert("Presents have been sent already"); 
        } */
    

    /* Реалізація з виводом строки з іменами іменинників. При реалізації Remix крашиться через раз.
        З локальним масивом краші взагалі постійні

    function findBirthday () public returns (string memory) {
        string memory birthdayNames;
        for (uint256 i = 0; i < _teammates.length; i++) {
            if (checkBirthday(i)) 
                birthdayNames = string(abi.encodePacked(birthdayNames, _teammates[i].name));
        }
            return birthdayNames;
    }
    */
    
    // функції на основі імпортованої бібліотеки
    // перевірка чи є сьогодні ДР у працівника
    function checkBirthday(uint256 index) view public returns(bool) {
        uint256 birthday = _teammates[index].birthday;
        (, uint256 birthday_month, uint256 birthday_day) = getDate(birthday);
        uint256 today = block.timestamp;
        (, uint256 today_month, uint256 today_day) = getDate(today);
        return (today_day == birthday_day && today_month == birthday_month) ? true : false;
    }

    function getDate(uint256 timestamp) pure public returns (uint256 year, uint256 month, uint256 day) {
        (year, month, day) = BokkyPooBahsDateTimeLibrary.timestampToDate(timestamp);
    }

    // Загальний функціонал 
    function deposit() payable public {}

    function getOwnerName() view public returns(string memory) {
        return _ownerName;
    }
    // Модифікатори
    modifier ownerOnly {
        require(msg.sender == _ownerAddress, "Could be done only by owner");
        _;
    } 

    // Alex_1,0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2,977837880
    // Ala_2,0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db,1006416456
    // Ira_3,0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB,819985080

    // function addAttribute(string memory attName, string memory value, uint256 index) public {
    //     _teammates[index][attName] = value;
    // }
    // modifier presentSentChecker {
    //     require(!_teammates[index].presentReceived, "Presents have been sent already");
    //     _;
    // }
}
