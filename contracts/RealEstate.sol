//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;


contract RealEstate {
    // current pictures, ownership papers, tax's papers, mortgage clearance, address, market rates, admin's commission
    uint256 property_no = 1;
    uint256 commission;
    uint256 fee;

    struct Property {
        string current_pictures;
        string ownership_papers;
        string tax_papers;
        string mortgage_clearance;
        string purchase_date;
        uint purchase_amount;
        address _owner;
        bool on_sale;
    }

    // constructor
    constructor(uint commission_, uint fee_) {
        commission = commission_;
        fee = fee_;
    }

    // mapping
    mapping(uint256 => Property) propertyData;

    // Readable function for admin interest
    function getAdmin()
        public
        view
        returns (
            uint256,
            uint256,
            uint256
        )
    {
        return (property_no, commission, fee);
    }

    // Readable function for property data
    function getData(uint256 my_property)
        public
        view
        returns (
            string memory,
            string memory,
            string memory,
            string memory,
            string memory,
            uint,
            address,
            bool
        )
    {
        Property storage pn = propertyData[my_property];
        return (
            pn.current_pictures,
            pn.ownership_papers,
            pn.tax_papers,
            pn.mortgage_clearance,
            pn.purchase_date,
            pn.purchase_amount,
            pn._owner,
            pn.on_sale
        );
    }

    // Write function
    function AddProperty(
        string memory _pictures,
        string memory _papers,
        string memory _tax,
        string memory _clearance,
        string memory _date
    ) public payable {
        propertyData[property_no] = Property(
            _pictures,
            _papers,
            _tax,
            _clearance,
            _date,
            msg.value,
            msg.sender,
            false
        );
    property_no++;
    }

    // Change Sale States
    function Sale(string memory _pics, uint _amount, bool _sale, uint my_property) public {
        Property storage pn = propertyData[my_property];
        require(msg.sender == pn._owner, "The Change can only be done by the Owner");
        pn.current_pictures = _pics;
        pn.purchase_amount = _amount*(10**18);
        pn.on_sale = _sale;
    }

    // Change Property States
    function Purchase(string memory _papers, string memory _date, uint my_property) public payable {
        Property storage pn = propertyData[my_property];
        require(pn.on_sale == true, "The Property must be available to sell.");
        require(msg.value > pn.purchase_amount, "The Purchase Amount must be greater than Specified Amount.");
        pn.ownership_papers = _papers;
        pn.purchase_date = _date;
        pn.purchase_amount = msg.value;
        pn._owner = msg.sender;
        pn.on_sale = false;
    }

    
}
