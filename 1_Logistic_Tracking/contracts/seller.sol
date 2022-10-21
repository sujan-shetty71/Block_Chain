    // SPDX-License-Identifier: MIT

    pragma solidity ^0.8.7;
    import "./logistic.sol";
    contract seller{
        //defining structure with mutliple candidate variables
        struct product{
            bool available;
            address pid;
            string name;
            uint price;
            string  _desc;
            uint productcount;

        }
        struct order{
                bool sold;
                uint pid;
                address id;
                string name;
                uint40 phno;
                string email;
                string location;
                address logi;
                bool send_to_ff;
            
            }
    
            logistic l;
            mapping (uint=> order) public orders;
            uint  orderCount;

           mapping (uint=> product) public products;
                uint public productcount;
                address owner;

        constructor(address _ad){
                        owner=_ad;
                        }

            modifier onlyOwner(){

            require(msg.sender==owner, "Not an seller");
            _;
                }
            function set_logistic(address ad) public {
                l=logistic(payable(ad));
            }
            
            function addProduct(string memory product_name,uint price,string memory _desc) public onlyOwner{
                productcount++;
                products[productcount]=product(true,msg.sender,product_name,price,_desc,productcount);

            } 

            function viewProduct(uint id) external view returns(bool,string memory,uint,string memory,address)   {
                bool s = products[id].available;
                address ad = products[id].pid;
                string memory name = products[id].name;
                uint p = products[id].price;
                string memory d=products[id]._desc;
                return (s,name,p,d,ad);
                
            }

            function getp(uint pid) external view returns (uint){
                return products[pid].price;
            }
        



            function purchase(uint pid,
            address _buyer,string memory name,uint40 ph,string memory _email,string memory _location,address logi) public payable  {
                    require(products[pid].available==true,"product is already purchased");
                    orderCount++;
                    orders[orderCount]=order(false,pid,_buyer,name,ph,_email,_location,logi,false);
                } 

            function orderdetails(uint pid) public returns(bool,
            uint,address,string memory, address,bool){
                require(orderCount>=1,"no orders");
                require(logistic_details(pid)==true,"ff not booked");   
                orders[pid].sold = true;
                products[pid].available=false;
            return (orders[pid].sold,orders[pid].pid,orders[pid].id,orders[pid].location,orders[pid].logi,logistic_details(pid));

            }
            function buyerdetails(uint pid) external  view returns(uint,string memory,uint40,string memory,string memory){
                return (orders[pid].pid,orders[pid].name,orders[pid].phno,orders[pid].email,orders[pid].location);
            }

            function logistic_details(uint oid) public view returns(bool){

                return l.ff_booked(oid);
            }

            function approve_delivary(uint oid) public  returns(bool) {
                require(orderCount==oid,"no orders");
                require(logistic_details(oid)==true,"ff not booked");
                orders[oid].send_to_ff=true;
                return orders[oid].send_to_ff;

            }

            function a_d(uint oid) public view returns(bool){
                return orders[oid].send_to_ff;
            }

        receive() external payable {}

        fallback() external payable {}
        
    }







