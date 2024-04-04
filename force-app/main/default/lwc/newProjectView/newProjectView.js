import { LightningElement} from 'lwc';


export default class NewProjectView extends LightningElement {
prodIds;

handleSelectedprodIds(event){
    this.prodIds = event.detail.prodIds;
}
}