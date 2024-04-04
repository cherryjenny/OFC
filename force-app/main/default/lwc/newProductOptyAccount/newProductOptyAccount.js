import { LightningElement ,api, wire} from 'lwc';
import getFilteredAccounts from '@salesforce/apex/newProductViewController.getFilteredAccounts';

export default class NewProductOptyAccount extends LightningElement {
    @api prodIds;
    cardTitle = "신제품 기회 거래처"
    errorMessage;

    rowData = [];
    colData = [
        {label: '거래처명', fieldName: 'accountName', type: 'text'},
        {label: '연락처', fieldName: 'phone', type: 'phone'},
        //지금까지 거래한 amount?
        //구매 했던 상품명?
    ];

   @wire(getFilteredAccounts, {prodIds: '$prodIds'})
   getFilteredAccountsFunction({error, data}){
    this.rowData = [];
    if (data) {
            
        // Format records into a structure matching the column definitions for the table
        this.rowData = data.map(rec => ({
            Id: rec.Id,
            accountName: rec.Name,
            phone: rec.phone
        }));
        this.errorMessage = null; // Clear any previous error
    } else if (error) {
        this.errorMessage = error.body.message;
    }
   }
}