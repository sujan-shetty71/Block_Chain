    // SPDX-License-Identifier: MIT
        import "./seller.sol";
        import "./clearence.sol";
        import "./buyer.sol";
        pragma solidity ^0.8.7;


        contract logistic {
            seller s;
            portclearence p;
            buyer bu;
            string st ="out for delivary";
            struct Freightforwarder {
                bool ff_booked;
                uint oid;
                address buy;
                bool recieved_ff;
                bool ff_initiates;
                bool recieved_buyer;
            }

            string su ="product delivered to customer";
            address owner;
             constructor(address ad){
                     owner=ad;
                    }
            modifier onlyOwner(){

        require(msg.sender==owner, "unauthorized request");
        _;
            }

            

             function set_seller(address ad) public {
               s=seller(payable(ad));
         }
           function set_clearence(address ad) public {
               p=portclearence(payable(ad));
         }
         function set_buyer(address ad) public {
               bu=buyer(payable(ad));
         }
            uint ffcount;
            // mapping (uint =>Ex_Clear) ex;
            // mapping (uint =>Im_Clear) im;
            mapping (uint => Freightforwarder) ff;
            uint public d_fees=100 wei;

            function Freightforward(uint oid,address buy) public payable  {
                                  
                 ffcount++;
                 ff[ffcount] = Freightforwarder(false,oid,buy,false,false,false); 
                 ff[ffcount].ff_booked=true;  
                     
            }

            function ff_booked(uint oid) public view  returns (bool){
                return ff[oid].ff_booked;
            }

            function order_rec(uint oid) public onlyOwner returns  (bool){
                require(s.a_d(oid)==true,"not packed from seller");
                ff[oid].recieved_ff=true;
                return ff[oid].recieved_ff;
            }
            function o_c(uint oid) public view returns(bool){
                return ff[oid].recieved_ff;
            }

            // write ff send code here and modify ff_send functon

            function buyer_details(uint oid) public view  returns(uint,string memory,uint40,string memory,string memory) {
                return s.buyerdetails(oid);
            }

            function send_to_port(uint oid) public onlyOwner returns (bool){
                    require(o_c(oid)==true,"ff not recieved order");
                    ff[oid].ff_initiates=true;
                    return ff[oid].ff_initiates;
            }
            function s_t_p(uint oid) public view returns(bool){
                   return ff[oid].ff_initiates;
            }

            function tracking(uint oid) public  view returns (string memory,string memory,string memory,string memory){
                require(s.a_d(oid)==true,"order is not packed from seller");
                require(s_t_p(oid)==true,"ff not initiated port clearence request");
                (string memory a ,bool b)=p.e_c(oid);
                require(b==true,"export clearence required");
                (string memory c , bool d) = p.i_c(oid);
                require(d==true,"import clearence required");
                
                require(order_recv_buyer(oid)==true,"out for delivary but not recived yet");
                return (a,c,st,su);

            }

            function order_recv_buyer(uint oid) public view returns(bool){
               return  bu.order_recived1(oid);
            }
          


    receive() external payable {}

    fallback() external payable {}
        }