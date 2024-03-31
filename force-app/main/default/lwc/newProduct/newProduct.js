import { LightningElement,  wire } from 'lwc';
import getNewProducts from "@salesforce/apex/newProductViewController.getNewProducts";
// import getPicklistOptions from "@salesforce/apex/newProductViewController.getPicklistOptions";


export default class NewProduct extends LightningElement {
    products;
    wiredResult;
    errorMessage;
    cardTitle = "신제품 기회창출";
    picklistOptions = [];
    rowData = [];
    colData = [
        {label: "신제품", fieldName: "Name", type: "text"},
        {label: "설명", fieldName: "Description", type: "text"},
        // {label: 'Family', fieldName: 'Family2', type: 'picklist', typeAttributes: { options: this.picklistOptions, placeholder: 'Select Family' }},
        // {label: "카테고리", fieldName: "Family", type: "text"}
         
    ];


    @wire(getNewProducts)
    wiredProducts(result){
        this.wiredResult = result;
        this.rowData = [];
        if (result.data) {
            this.rowData = result.data.map((rec) => ({
                ProdId: rec.Id,
                Name: rec.Name,
                Family: rec.Family ? rec.Family : '',
                Description : rec.Description
            }));
            this.errorMessage = null;
        } else if (result.error) {
            this.errorMessage = result.error.body.message;
        }
    }

    handleRowSelection(event) {
        let ids; // IDs of selected products
        // Identify the IDs of selected products (if any)
          this.selectedRows = event.detail.selectedRows;
          ids = this.selectedRows.map((r) => r.ProdId);
    

        // Create and dispatch a custom event
        const evt = new CustomEvent("selectedprodids", {
          detail: { prodIds: ids }
        });
        this.dispatchEvent(evt);
    }


    // @wire(getPicklistOptions)
    // wiredPicklistOptions({ error, data }) {
    //     if (data) {
    //         this.picklistOptions = data.map((option) => ({ label: option, value: option }));
    //     } else if (error) {
    //         console.error(error);
    //     }
    // }


}