            // SPDX-License-Identifier: MIT
            import "./seller.sol";
            import "./logistic.sol";
            pragma solidity ^0.8.7;



            contract buyer {
                seller s;
                logistic l;
                
                struct rec{
                    bool recv;
                }
                
                string d="order recived";
                mapping (uint=>rec) rc;
            //to set seller address
                function setSeller(address _seller) public{
                    s=seller(payable(_seller));
                }

                function setlogistic(address _logistic) public{
                    l=logistic(payable(_logistic));
                }


            //to check available product with seller
                function avalable_product(uint256 id) public  view  returns (bool,string memory,
                uint,string memory,address)
                {
                    return s.viewProduct(id);
                } 

            //to purchase product from seller by sending ether
                function purchase(uint pid,
                string memory name,uint40 ph,string memory _mail,string memory _location,address f_f) 
                public payable  {
                    address buy=msg.sender;
                    uint price = s.getp(pid);
                    rc[pid]=rec(false);
                    require(f_f!=address(0x00),"invalid fright_forwarder");
                    require(msg.value == price,"Appropraite ether not sent to seller");
                    (bool success, ) = payable(s).call{value: msg.value}("");
                    require(success, "Failed to send Ether");
                    return s.purchase(pid,buy,name,ph,_mail,_location,f_f);
                } 

                function send_d_fees(uint oid) public payable {
                    address buy=msg.sender;
                    require(msg.value == 100 wei,"Appropraite ether not sent to fright");
                    (bool success, ) = payable(l).call{value: msg.value}("");
                    require(success, "Failed to send Ether");
                    return l.Freightforward(oid,buy);
                }
                //to view order detials
                function orderdetails(uint pid) public  returns(bool,
            uint,address,string memory, address,bool){
                            
                            return s.orderdetails(pid);
                    }

            function tracking(uint pid) public view returns(string memory,string memory,string memory,string memory,bool){
                (string memory a,string memory b,string memory c,string memory dd)=l.tracking(pid);
                require(rc[pid].recv==true,"out for delivary but not recieved procuct");
                return (a,b,c,dd,rc[pid].recv);
                
            }

            function order_recived(uint pid) public returns(bool){
                rc[pid].recv=true;
                return rc[pid].recv;
            }

            function order_recived1(uint pid) public view returns(bool){
                return rc[pid].recv;
            }        

            } 
