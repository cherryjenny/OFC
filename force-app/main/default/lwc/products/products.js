import { LightningElement, track } from 'lwc';
import getProducts from '@salesforce/apex/ProductController.getProducts';

export default class Gallery extends LightningElement {
    @track products = [];
    @track selectedProductId;
    @track selectedProductName;
    @track selectedProductDescription;
    @track selectedProductFamily;
    @track selectedProductPrice;
    @track selectedProductUnit;
    @track selectedProductImageURL;

    connectedCallback() {
        this.loadProducts();
    }

    async loadProducts() {
        try {
            const result = await getProducts();
            if (result) {
                this.products = result;
            }
        } catch(error) {
            console.error('Error loading products', error);
        }
    }

    handleProductClick(event) {
        this.selectedProductId = event.currentTarget.dataset.id;
        this.selectedProductName = event.currentTarget.dataset.name;
        this.selectedProductDescription = event.currentTarget.dataset.description;
        this.selectedProductFamily = event.currentTarget.dataset.family;
        this.selectedProductPrice = event.currentTarget.dataset.price;
        this.selectedProductUnit = event.currentTarget.dataset.unit;
        this.selectedProductImageURL = event.currentTarget.dataset.image;
    }

    handleCloseInfo() {
        this.selectedProductId = null;
        this.selectedProductName = null;
        this.selectedProductDescription = null;
        this.selectedProductFamily = null;
        this.selectedProductPrice = null;
        this.selectedProductUnit = null;
        this.selectedProductImageURL = null;
    }
}