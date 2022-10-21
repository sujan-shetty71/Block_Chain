    // SPDX-License-Identifier: MIT
        import "./logistic.sol";
        pragma solidity ^0.8.7;

        contract portclearence {
            logistic l;
            address ec;
            address ic;
            string s ="done with export clearence";
            string a ="done with import clearence";

            struct Ex_Clear{
                bool e_c;
                uint oid;
            }

            struct Im_Clear{
                bool i_c;
                uint oid;
            }

            mapping (uint =>Ex_Clear) public ex;
            mapping (uint =>Im_Clear) public im;
           address ExportClearanceAuthority;
           address importClearanceAuthority;
           constructor(address _ExportClearanceAuthority,address _importClearanceAuthority){
                 ExportClearanceAuthority = _ExportClearanceAuthority;
                 importClearanceAuthority = _importClearanceAuthority;
    }
           modifier onlyExport(){

        require(msg.sender==ExportClearanceAuthority, "unauthorised--Export");
        _;
            }
            modifier onlyImport(){

        require(msg.sender==importClearanceAuthority, "unauthorised -- import");
        _;
            }

            function set_logistic(address ad) public {
               l=logistic(payable(ad));
         }

          function e_clearence(uint oid) public onlyExport returns(string memory,bool) {
                  require(l.s_t_p(oid)==true,"not recieved export port clearence request from ff");
                  ex[oid].e_c=true;
                  return (s,ex[oid].e_c);
            }
            function e_c(uint oid) public view returns(string memory,bool){
                return (s,ex[oid].e_c);
            }
            function i_clearence(uint oid) public onlyImport returns(string memory,bool) {
                  require(ex[oid].e_c==true,"export clearence is pending");
                  im[oid].i_c=true;
                  return (a,im[oid].i_c);
            }
            function i_c(uint oid) public view returns(string memory,bool){
                   return (a,im[oid].i_c);
            }
            
            
        }