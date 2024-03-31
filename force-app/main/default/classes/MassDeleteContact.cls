public with sharing class MassDeleteContact {

    public Integer numberRecords {get; private set;}
    public ApexPages.StandardSetController setCon {get; private set;}
    public List<Contact> contacts {get; private set;}
    public String errorMessage {get; private set;}


    public MassDeleteContact(ApexPages.StandardSetController stdSetController) {
        setCon = stdSetController;
        List<Contact> selectdContacts = (List<Contact>)setCon.getSelected();
        numberRecords = selectdContacts.size();

        if(numberRecords > 0){
            Set<Id> selectedIDs = new Set<Id>();
            for(Contact c : selectdContacts){
                selectedIDs.add(c.Id);
            }
            contacts = [SELECT Id, Name From Contact WHERE Id In : selectedIDs];
        }
    }

    public PageReference okDelete(){
        try{
            delete contacts;
            numberRecords = -1;
        }
        catch(Exception e){
            numberRecords = -2;
            errorMessage = e.getMessage();
        }
        return null;
    }

    public pageReference okCancel(){
        return setCon.cancel();
    }
}